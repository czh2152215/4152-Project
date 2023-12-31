# SmartArtGuide: Where Art Comes to Life.

## Team member:

- Zihao Cui zc2715

- Shulin Chen sc5320

- Yixiao Yuan yy3425

- Lingxi Zhou lz2648

  

# Minimal Viable Prototype(Heroku link): [SmartArtGuide](https://safe-ravine-39931-4dcfeebeaa67.herokuapp.com/)(iter1)



# MVC

1. SessionsController and its View: welcome, login, logout
2. UsersController and its View: register, profile
3. ArtworksController and its View: main, show
4. LikesController and its View: like, cancel_like (to implement in next iteration)
5. ImageSearchController and its view: upload, search




# Framework version

- Ruby version: 3.2.2
- Rails version: 7.1.1
- Using 'gem update bundler' Make sure you have your bundle update to the latest version

# Set up

- Double check the version that you are using
- Use 'bundle install' to installed Gem package
- Use 'rails db:create' to create the database
- Use 'rails db:schema:load' to load the current schema
- Use 'rails db:migrate' to apply any missing migrations
- Use 'rails db:seed' to load database
- Use 'rails server -p 8080' to start the project, the project will run at localhost:8080

# Functions

- Users can register, log-in, log-out, and edit their information
- Users can upload images and get redirected to a detail page for that artwork, if the image cannot be recognized, we will return "No artwork found for the uploaded image."
  - Image recognition will be implmented in our next iteration, currently upload a random picture will redirect to "Starry Night" details page by default
  - To test the unhappy scenario, upload the image from this path: "features/support/fixtures/no_match_image.jpeg"

# Testing

- run 'bundle exec cucumber': current coverage 95.8%
- run 'bundle exec rspec': current coverage 100%

# Deployment
- We deploy our application on Heroku using the subsequent commands

```
git pull
heroku login -i
git checkout master
heroku create
heroku stack:set heroku-20
heroku addons:create heroku-postgresql
git push heroku master
heroku run rake db:migrate
```

