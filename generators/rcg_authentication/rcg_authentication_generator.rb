# TODO copy components

class RcgAuthenticationGenerator < Rails::Generator::NamedBase
  default_options :base => "app/flex"

  attr_reader :base_package_name # Base Package Name

  def initialize(runtime_args, runtime_options={ })
    super

    @base_package_name = class_name.downcase
    @base_package_path = @base_package_name.gsub('.', '/')
  end

  def manifest
    record do |m|

      m.template 'rubyamf_config.rb', File.join("config", "rubyamf_config.rb")

      m.template 'LoginBox.mxml',
      File.join(options[:base],
                @base_package_path,
                'components', "LoginBox.mxml")

      m.template 'SplashBox.mxml',
      File.join(options[:base],
                @base_package_path,
                'components', "SplashBox.mxml")

      # User vo
      user_model_class = "User"
      user_model_name = "#{@base_package_name}.model.#{user_model_class}"

      user_vo_class = "#{user_model_class}VO"
      user_vo_name = "#{@base_package_name}.vo.#{user_vo_class}"

      # Create UserVO with template
      m.template 'UserVO.as',
      File.join(options[:base],
                @base_package_path,
                'vo', 'UserVO.as')

      # Create UserModel with template
      m.template 'User.as',
      File.join(options[:base],
                @base_package_path,
                'model', 'User.as')
      m.template 'UserBase.as',
      File.join(options[:base],
                @base_package_path,
                'model', 'UserBase.as')

      # Session delegate
      m.template 'SessionDelegate.as',
      File.join(options[:base],
                @base_package_path,
                'business', 'SessionDelegate.as')

      # Session commands
      m.template 'CreateSessionCommand.as',
      File.join(options[:base],
                @base_package_path,
                'command', 'CreateSessionCommand.as')

      m.dependency 'rcg_command', ["CreateSession", "#{base_package_name}", "--skip-create"]

      m.template 'DestroySessionCommand.as',
      File.join(options[:base],
                @base_package_path,
                'command', 'DestroySessionCommand.as')

      m.dependency 'rcg_command', ["DestroySession", "#{base_package_name}", "--skip-create"]

      # Add Login features to ApplicationModelLocator
      model_locator_path = "#{options[:base]}/#{@base_package_path}/model/ApplicationModelLocator.as"
      model_locator_str = open("#{RAILS_ROOT}/#{model_locator_path}").read
      login_str = <<-EOS
    private var _user:User;

        public function set user(user:User):void{
            this._user = user;
            workflowState = VIEWING_MAIN_APP;
        }

        public function get user():User{
            return this._user;
        }
EOS
      unless model_locator_str =~ /(#{Regexp.escape(login_str)})/mi
        add_reg = "Login Stuff"
        m.gsub_file model_locator_path,
        /(#{Regexp.escape(add_reg)})/mi do |match|
          "#{match}\n\n    #{login_str}"
        end
      end

      # Add Service
      services_path = "#{options[:base]}/#{@base_package_path}/business/Services.mxml"
      services_str = open("#{RAILS_ROOT}/#{services_path}").read

      login_service_str = <<-EOS
<mx:RemoteObject id="sessionRO"
        source="SessionsController"
        destination="rubyamf">
        <mx:method name="create"/>
        <mx:method name="destroy"/>
    </mx:RemoteObject>
EOS
      unless services_str =~ /(#{Regexp.escape(login_service_str)})/mi
        add_reg = "xmlns:cairngorm=\"http:\/\/www.adobe.com\/2006\/cairngorm\">"
        m.gsub_file services_path,
        /(#{Regexp.escape(add_reg)})/mi do |match|
          "#{match}\n\n    #{login_service_str}"
        end
      end

      # Add Login component to your SplashBox component

      # Add Parameter Mapping

    # ParameterMappings.register(:controller => :SessionsController, :action => :create, :params => { :login => "[0]", :password => "[1]" })

      puts "#########################################"
      puts "Authentication generated"
      puts "Copy text blow to"
      puts " your config/rubyamf_config.rb"
      puts "#########################################"

      puts "ParameterMappings.register(:controller => :SessionsController, :action => :create, :params => { :login => \"[0]\", :password =>\"[1]\" })"
    end
  end

  protected
  def banner
    "Usage: #{$0} rcg_authentication [base_package]"
  end

  def add_options!(opt)
    opt.separator ''
    opt.separator 'Options:'
    opt.on("-b", "--base=path", String, "Base path to generate Flex essentials.", "Default: #{default_options[:base]}"){ |v| options[:base] = v}
  end
end
