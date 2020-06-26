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
    
    # binding.pry
    if !params["owner_name"].empty?
      owner = Owner.create(name: params[:owner_name])
    elsif params[:pet][:owner_id][0]
      owner = Owner.find_by_id(params[:pet][:owner_id][0].to_i)
    end
    @pet = Pet.create(name: params[:pet][:name], owner_id: owner.id)
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find_by_id(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find_by_id(params[:id])
    @owners = Owner.all
    # binding.pry
    erb :'/pets/edit'
  end

  patch '/pets/:id' do 
    @pet = Pet.find_by_id(params[:id])
    @pet.update(params[:pet])
    if !params[:owner][:name].empty?
      @pet.owner = Owner.create(name: params[:owner][:name])
    elsif params[:pet][:owner_id][0]
      @pet.owner = Owner.find_by_id(params[:pet][:owner_id][0].to_i)
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end