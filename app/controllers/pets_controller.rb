class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owner = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do

    @pet = Pet.create(params[:pet])

    if !params[:owner][:name].empty?
    @pet.owner = Owner.create(name: params[:owner][:name])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owner = Owner.all
    erb :'/pets/edit'
  end



get '/pets/:id' do
  @pet = Pet.find(params[:id])
  erb :'/pets/show'
end

patch '/pets/:id' do
  @pet = Pet.find_by_id(params[:id])
  @pet.owner_id = nil
  @pet.save
    if !params[:pet].keys.include?("owner_ids")
      params[:pet]["owner_ids"] = []
    end

  @pet = Pet.find(params[:id])

  @pet.update(name: params[:pet]["name"])

    if !params[:owner][:name].empty?
      @pet.owner = Owner.create(name: params[:owner][:name])
      @pet.save
    end

      redirect to "pets/#{@pet.id}"
  end
end
