# frozen_string_literal: true

require 'sinatra'
require 'json'
require 'securerandom'
require 'erb'

MEMO_FILE = 'memo.json'

File.exist?(MEMO_FILE) || File.write(MEMO_FILE, JSON.generate({}))

def load
  JSON.parse(File.read(MEMO_FILE))
end

def save(memos)
  File.write(MEMO_FILE, "#{JSON.pretty_generate(memos)}\n")
end

def h(text)
  ERB::Util.html_escape(text)
end

get '/' do
  @memos = load
  @title = 'メモ一覧'
  erb :index
end

get '/memos/new' do
  @title = '新規メモ作成'
  erb :new
end

post '/memos' do
  memos = load
  id = SecureRandom.uuid
  memos[id] = { 'title' => params[:title], 'content' => params[:content] }
  save(memos)
  redirect '/'
end

get '/memos/:id' do
  @id = params[:id]
  @memo = load[@id]

  if @memo
    @title = @memo['title']
    erb :show
  else
    halt 404, 'メモが見つかりません'
  end
end

get '/memos/:id/edit' do
  @id = params[:id]
  @memo = load[@id]

  if @memo
    @title = 'メモ編集'
    erb :edit
  else
    halt 404, 'メモが見つかりません'
  end
end

patch '/memos/:id' do
  memos = load
  id = params[:id]

  if memos[id]
    memos[id]['title'] = params[:title]
    memos[id]['content'] = params[:content]
    save(memos)
    redirect "/memos/#{id}"
  else
    halt 404, 'メモが見つかりません'
  end
end

delete '/memos/:id' do
  memos = load
  memos.delete(params[:id])
  save(memos)
  redirect '/'
end
