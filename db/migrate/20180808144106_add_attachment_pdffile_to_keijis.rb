class AddAttachmentPdffileToKeijis < ActiveRecord::Migration[5.1]
  def self.up
    change_table :keijis do |t|
      t.attachment :pdffile
    end
  end

  def self.down
    remove_attachment :keijis, :pdffile
  end
end
