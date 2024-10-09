# frozen_string_literal: true

require 'sinatra'
require 'pg'
require 'securerandom'
require 'erb'

configure do
  set :db_connection, PG.connect(dbname: 'sinatra_memo')
end

before do
  @db = settings.db_connection
  @db.reset if @db.finished?
end

def h(text)
  ERB::Util.html_escape(text)
end

def load(id = nil)
  if id
    @db.exec_params('SELECT * FROM memos WHERE uuid = $1 LIMIT 1', [id]).first
  else
    @db.exec('SELECT * FROM memos ORDER BY created_at DESC')
  end
end

def create(title, content)
  uuid = SecureRandom.uuid
  @db.exec_params('INSERT INTO memos (uuid, title, content) VALUES ($1, $2, $3)', [uuid, title, content])
end

def update(id, title, content)
  @db.exec_params('UPDATE memos SET title = $1, content = $2, updated_at = NOW() WHERE uuid = $3', [title, content, id])
end

def delete(id)
  @db.exec_params('DELETE FROM memos WHERE uuid = $1', [id])
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
  create(params[:title], params[:content])
  redirect '/'
end

get '/memos/:id' do
  @memo = load(params[:id])

  if @memo
    @title = @memo['title']
    erb :show
  else
    halt 404, 'メモが見つかりません'
  end
end

get '/memos/:id/edit' do
  @memo = load(params[:id])

  if @memo
    @title = 'メモ編集'
    erb :edit
  else
    halt 404, 'メモが見つかりません'
  end
end

patch '/memos/:id' do
  update(params[:id], params[:title], params[:content])
  redirect "/memos/#{params[:id]}"
end

delete '/memos/:id' do
  delete(params[:id])
  redirect '/'
end
