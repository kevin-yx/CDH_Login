# 生成pdf测试
class GenaratePdfsController < ApplicationController

  # 通过URL导出pdf
  def index
    url = "http://www.xjgreat.com/"

    kit = PDFKit.new(url)
    send_data(kit.to_pdf, :filename => "mypdf.pdf", :type => "application/pdf")
  end

  # 通过html文件导出pdf
  def export_by_css
    # html = render_to_string(:template => "pdf_template.erb", :layout => false)
    html = render_to_string(action: 'report_page2', layout: false)



    kit = PDFKit.new(html, :page_size => 'Letter')
    kit.stylesheets << "#{Rails.root}/app/assets/stylesheets/index.css"

    pdf = kit.to_pdf
    # send_data(kit.to_pdf, :filename => "mypdftest.pdf", :type => "application/pdf")
    send_data pdf, :filename => "mytest2.pdf",
              :type => "application/pdf",
              :disposition => "attachment"
  end

  def report_page

  end

  # 导出狂拽炫酷吊炸天
  def report_page2

  end
end
