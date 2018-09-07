class Keiji < ApplicationRecord
    has_attached_file :pdffile, :dependent => :destroy,
    :path =>  "#{Rails.root}/public/system/:class/:id/:filename",
    :url => "system/:class/:id/:filename",
    :default_url => "system/:class/missing/:filename"
    validates_attachment_content_type :pdffile, :content_type => [ 'application/pdf', 'image/jpeg' ], :message => "は、PDF・jpeg にしてください"
    validates_attachment_size :pdffile, :less_than => 5.megabytes, :message => "サイズは、５MBまでです"
    validates_attachment_presence :pdffile, :message=>"が選択されていません"

    validates :title, presence: {:message => "を入力してください"}
    validates :end, presence: {:message => "を入力してください"}


    #    belongs_to :category
end
