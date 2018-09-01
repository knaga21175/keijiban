class MyMailer < MyMailer
    default :from => ENV['MAIL_ADDRESS']
    layout 'mailer'
    
    # Subject can be set in your I18n file at config/locales/en.yml
    # with the following lookup:
    #
    #   en.my_mailer.kokuti.subject
    #
    
    ###########################
    ### ユーザー登録通知メール
    ###########################
    def usermailin( user )
        @user = user
        sub = "メールアドレス登録通知"
        mail(:to => user.mail, :subject => sub )
    end
    
    ###########################
    ### お知らせ 登録通知メール
    ###########################
    def kokuti( keiji, address )
        @keiji = keiji
        sub = "掲示板登録のお知らせ"
        mail(:to => address, :subject => sub )
    end
    
    ###########################
    ### メール受信処理
    ### PostFix からコールされる
    ###########################
    def receive(email)
        
        logger = Logger.new('log/Mailin.log')
        logger.error email.from.first
        logger.error email.subject
        
        sub = email.subject.encode("UTF-8")
        
        ##############################
        ### ユーザー登録の場合に処理 ###
        ##############################
        if ( sub == "signup".encode("UTF-8"))
            logger.error "件名判断完了"
            # 既に登録済みのメールアドレスならNGとする
            _rs = User.where( "mail=?", email.from.first )
            if ( _rs.count != 0 )    # 登録済み
                MyMailer.usermailin( _rs ).deliver  # メール通知
                return
            end
            
            # 登録情報セット
            @resident = User.new
            @resident.mail = email.from.first  # 発信者メールアドレス取得
            
            # save
            if @resident.save( validate: false )
                MyMailer.usermailin( @resident ).deliver  # メール通知
            else
                # 異常通知メール
                logger.error "メール通知異常"
                message = "メールアドレス登録で異常が発生しました"
                @custemer.errors.full_messages.each do |msg|
                    message = message + "\n" + msg
                end
                return
            end
        end
    end
end
    