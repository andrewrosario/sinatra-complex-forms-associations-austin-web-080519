require 'pry'
class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    if !params['owner_name'].empty?
      @owner = Owner.create(name: params['owner_name'])
      @pet = Pet.create(name: params['name'], owner_id: @owner.id)
    else
      @pet = Pet.create(name: params['name'], owner_id: params['owner_id'])
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do 
    @pet = Pet.find(params[:id])
    @pet.name = params['name']
    if !params['owner_name'].empty?
      @owner = Owner.create(name: params['owner_name'])
      @pet.owner_id = @owner.id
    else
      @pet.owner_id = params['owner']['name']
    end
    @pet.save
    # binding.pry
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do 
    @pet = Pet.find(params[:id])
    @owner = @pet.owner
    @all_owners = Owner.all
    erb :'/pets/edit'
  end
end