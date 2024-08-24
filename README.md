# Conway’s Game of Life  (API)
This Ruby on Rails API application implements the rules for Conway's Game of Life. It provides simple REST endpoints that cover the basic cases for a front-end client consumer.

Please refer to Conway's Game of Life rules as seen here: [https://playgameoflife.com/](https://playgameoflife.com/)

The basic rules are as follows:
- For a space that is populated:
  - Each cell with one or no neighbors dies, as if by solitude.
  - Each cell with four or more neighbors dies, as if by overpopulation.
  - Each cell with two or three neighbors survives.
- For a space that is empty or unpopulated:
  - Each cell with three neighbors becomes populated.

## Getting Started

This app uses Rails [version 7.2](https://rubyonrails.org/2024/8/10/Rails-7-2-0-has-been-released), which introduces a very cool feature of dev containers. Therefore, the app can run smoothly in a Docker container. You just need to have Docker installed and running on your machine. If you are using VS Code, the Docker extension comes in very handy.

To get started:
- [Get Docker and Docs](https://docs.docker.com/get-started/get-docker/)
- [VS Code Dev Containers](https://code.visualstudio.com/docs/devcontainers/containers)

Once in the container console, start your Rails app as you would usually do.

**Install the gems and dependencies**
```shell
bundle install
```

**Create the database**
```shell
rails db:create
```

**Run Migrations**
```shell
rails db:migrate
```

**Start your development server**
```shell
rails server
```

After that, you should be good to go and see the famous Rails welcome page at [http://localhost:3000](http://localhost:3000).

## Read the Docs
This app implements Rswag for complete Swagger documentation experience, you hit the endpoints directly from the doc page. 

Check out the endpoint requirements and play around with them by hitting your development server at `/api-docs`. Assuming you are running Rails on your localhost at port 3000, the URL would look like this: [http://localhost:3000/api-docs](http://localhost:3000/api-docs).

Enjoy!

### License
### The MIT License (MIT)
Copyright © 2024 <copyright holders>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
