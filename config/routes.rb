SimpleImageCropExample::Application.routes.draw do
    resources :advertisements, as: "ads", path: "ads", only: [:index, :show, :new, :create]
    resources :pictures, as: "ad_pics", only: [:create, :update] do
    	post "edit", on: :member
    end
    
    root "advertisements#index"
end
