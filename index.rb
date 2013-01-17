require 'rubygems'
require 'active_resource'
require 'sinatra'

class Iteration < ActiveResource::Base
	self.format = :xml
	self.site = "http://www.pivotaltracker.com/services/v3/projects/:project_id"
	self.proxy = ENV["HTTP_PROXY"] if ENV["HTTP_PROXY"]
	headers['X-TrackerToken'] = 'a4f83e5418d75d3b9b46cb2734c0af1d'
end

get "/" do
	#PROJECT_ID = ARGV[0]
	PROJECT_ID = 342025
	raise ArgumentError.new('Please specify project id (like "64534")') if PROJECT_ID.nil?

	current_iteration = Iteration.find(:all, :params => {:project_id => PROJECT_ID, :group => "current"})
	iterations_backlog = Iteration.find(:all, :params => {:project_id => PROJECT_ID, :group => "backlog"}) 

	@iterations = current_iteration + iterations_backlog

	erb :iterations
end
