# 模拟CDH登陆
require "mechanize"
require 'watir-webdriver'
require 'net/https'
require 'uri'
require 'rest-client'
module EasyHTTP
  class HTTP
    def initialize(url)
      @url = url
      @cookie = nil
    end

    def login
      uri = URI.parse(@url)
      params = {}
      params['j_username'] = 'admin'
      params['j_password'] = 'admin'
      res = Net::HTTP.post_form(uri, params)
      @cookie = res.header['set-cookie'].split(';')[0]
    end

    def get(url)
      login unless @cookie
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Get.new(uri.path)
      request['Cookie'] = @cookie
      res = http.request(request)
      res.body
      @cookie

    end
  end
end

class ChdLoginController < ApplicationController

  def abc
    sample = EasyHTTP::HTTP.new("http://120.27.163.174:7180/j_spring_security_check")
    ck_info = sample.get("http://120.27.163.174:7180/cmf/home")
    # @access_url = "http://120.27.163.174:7180/cmf/home"
    # redirect_to "http://120.27.163.174:7180/cmf/home"
    cookies['CLOUDERA_MANAGER_SESSIONID']= ck_info.split('=')[1]


    redirect_to "http://120.27.163.174:7180/cmf/home"
  end

  def index
    url = URI.parse('http://120.27.163.174:7180/j_spring_security_check')
    response = Net::HTTP.post_form(url, {'j_username' => "admin",
                                         'j_password' => "admin"
    })


    cooke_info = response.header['set-cookie'].split(';')[0]

    #http://114.55.41.98:7180/cmf/login
    # response = RestClient.get('http://120.27.163.174:7180/j_spring_security_check',
    #                           {j_username: 'admin', j_password: 'admin'})
    # response = RestClient.post('http://120.27.163.174:7180/j_spring_security_check',
    #                            {j_username: 'admin', j_password: 'admin'},
    #                            headers={}
    # )
    # cooke_info = response.cookies.values.first

    @response2 = RestClient::Request.execute(
        method: :get,
        url: 'http://120.27.163.174:7180/cmf/home'

    )
    @access_url = URI.parse('http://120.27.163.174:7180/cmf/home')
    # res = Net::HTTP.post_form(url, {j_username: 'admin', j_password: 'admin'})
    # cook_tmp = res.header['set-cookie']

    # response2 = RestClient.post(
    #     'http://120.27.163.174:7180/cmf/home',
    #      {:param1 => "foo"},
    #     {:cookies => {:session_id => cooke_info}}
    # )
    # @response2 = RestClient::Request.execute(
    #     method: :get,
    #     url: 'http://120.27.163.174:7180/cmf/home',
    #     cookies: {session_id: cooke_info}
    # )

    # @response2= RestClient.get('http://120.27.163.174:7180/cmf/home',
    #                            {cookies: {session_id: cooke_info}}
    #
    # )

    puts @response2.body.to_s
  end

  def bbb
    # agent = Mechanize.new
    # login_page = agent.get "http://120.27.163.174:7180/cmf/login"
    # login_form = login_page.forms.first
    #
    # username_field = login_form.field_with(:name => "j_username")
    # username_field.value = "admin"
    # password_field = login_form.field_with(:name => "j_password")
    # password_field.value = "admin"
    #
    # # 登陆页面登陆成功
    # step2_page = agent.submit login_form
    # tmp_cookie = agent.cookie_jar
    # home_page = agent.get("http://120.27.163.174:7180/cmf/home")
  end

  def login_test
    # agent = Mechanize.new
    # login_page = agent.get "http://120.27.163.174:7180/cmf/login"
    # login_form = login_page.forms.first
    #
    # username_field = login_form.field_with(:name => "j_username")
    # username_field.value = "admin"
    # password_field = login_form.field_with(:name => "j_password")
    # password_field.value = "admin"
    #
    # # 登陆页面登陆成功
    # step2_page = agent.submit login_form
    # tmp_cookie = agent.cookie_jar
    #
    #
    # # index_page = agent.get("http://120.27.163.174:7180/api/v11/clusters/Cluster1/services/impala/impalaQueries")
    #
    # home_page = agent.get("http://120.27.163.174:7180/cmf/home")
    #
    # cookies['CLOUDERA_MANAGER_SESSIONID'] = agent.cookie_jar.cookies(URI.parse("http://120.27.163.174:7180/cmf/home")).first.value
    # # @current_url = index_page.uri
    # # doc = Nokogiri::HTML(open(index_page.uri.to_s))
    # # puts doc
    # puts home_page.body
    # @html_info = home_page.body
    # @current_url = home_page.uri
    # # index_page.open()
    # # render :plain => home_page.body.to_s
  end

  def login_with_cookie
    agent = Mechanize.new

    login_page = agent.get "http://120.27.163.174:7180/cmf/login"
    login_form = login_page.forms.first

    username_field = login_form.field_with(:name => "j_username")
    username_field.value = "admin"
    password_field = login_form.field_with(:name => "j_password")
    password_field.value = "admin"

    step2_page = agent.submit login_form
    tmp_cookie = agent.cookie_jar
    cookies['CLOUDERA_MANAGER_SESSIONID'] = agent.cookie_jar.cookies(URI.parse("http://120.27.163.174:7180/cmf/login")).first.value
    # redirect_to 'http://120.27.163.174:7180/cmf/home'
    # agent.open('http://120.27.163.174:7180/cmf/home')
    # cv = agent.cookie_jar.cookies(URI.parse("http://120.27.163.174:7180/cmf/home")).first.value
    #
    # cookie = Mechanize::Cookie.new('CLOUDERA_MANAGER_SESSIONID', cv)
    # cookie.domain = "120.27.163.174:7180"
    # cookie.path = "/"
    # agent.cookie_jar.add(cookie)
    index_page = agent.get("http://120.27.163.174:7180/cmf/home")

    # # cookies['CLOUDERA_MANAGER_SESSIONID'] = agent.cookie_jar.cookies(URI.parse("http://120.27.163.174:7180/cmf/home")).first.value
    #
    #
    # @current_url = index_page.uri
  end

  def login_other_method
    b = Watir::Browser.new :chrome

    login_url = "http://120.27.163.174:7180/cmf/login"


    b.goto login_url
    b.text_field(:name => 'j_username').set "admin"
    b.text_field(:name => 'j_password').set "admin"

    b.button(:name => 'submit').click
    # b.driver.manage.window.maximize
    # puts b.url

    # b.goto('http://120.27.163.174:7180/cmf/home')
    # b.close
  end

  def test_login

  end

end
