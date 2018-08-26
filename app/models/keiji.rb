class Keiji < ApplicationRecord
    has_attached_file :pdffile, :dependent => :destroy,
    :path =>  "#{Rails.root}/public/system/:class/:id/:filename",
    :url => "system/:class/:id/:filename",
    :default_url => "system/:class/missing/:filename"
    validates_attachment_content_type :pdffile, :content_type => 'application/pdf', :message => "PDFファイルではありません"
    validates_attachment_size :pdffile, :less_than => 3.megabytes, :message => "ファイルサイズは、３MBまでです"
    validates_attachment_presence :pdffile, :message=>"ファイルが選択されていません"

    validates :title, presence: {:message => "タイトルを入力してください"}


    #    belongs_to :category
end
