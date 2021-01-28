Rails.application.routes.draw do
devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
root to: 'home#index' 
resources :notes
resources :books
 # Agregados para hacer el pase desde Book a Note
get 'books/:book_id/notes', to: 'notes#index_notes_of_book', as: 'notes_of_book'
get 'books/:book_id/notes/:note_id', to: 'notes#show'
get 'books/:book_id/note', to: 'notes#new_note_of_book', as: 'new_note_of_book'
get 'notes/:id/download', to: 'notes#download', as: 'download'
get 'books/:id/download', to: 'books#download', as: 'download_zip'
get 'download', to: 'books#download_all', as: 'download_all'
end
