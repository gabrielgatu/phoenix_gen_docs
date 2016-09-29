# Phoenix Api Docs Generator

It's a very small tool for generating API documentation for phoenix based applications.

## How it works

This tool tries to get all the routes contained in the `AppName.Router` module. Then, for each
of the routes found, it takes the function documentation and finally generates a HTML page for
each route.

## Why

Currently I'm developing a REST API, consumed by an angular application, and sometimes I forget
the precise arguments I need to send, or the response type I get back. 
So I've developed this small tool just to help me :)

## Status

It's currently stable (but tested only on my machine/project, hope it's allright also for you :)). It takes
only the function documentation for now, maybe in the future I'll add other functionalities, like:

- Linking to other routes
- Support for json coloring / other languages maybe...
- Support for including common piece of documentation (like an import)
- Infer automatically the return value by parsing the relative view (hard and don't know if it's a good idea...)

## Installation

To use this project just add this to mix.exs

```elixir
{:phoenix_gen_docs, git: "https://github.com/gabrielgatu/phoenix_gen_docs", only: :dev}
```

And

`mix deps.get`
`mix compile`

Then use `mix phoenix.gen.docs` for generating the API docs. That's it :)

## Usage

Just write the documentation at the top of your action functions. Of course,
markdown is supported and highly suggested.

Example: if you have in your router

`get "/user/:id", MyController, :show`

Then in the MyController module, above
the `def show(conn, params) do` function,
you'll write the docs.

```elixir
@doc """
Given an integer id in url params, it returns the relative user

### Parameters

- id: Integer

### Result

{
  status: Integer,
  data: {
    id: Integer,
    username: String,
    email: String
  },
  errors: null | errors
}
"""
def show(conn, params) do
...
end
```

Automatically it will be used as a documentation for this route.

All the docs are contained inside the **/docs** folder, at the root
of your project.

## License

The MIT License (MIT)

Copyright (c) 2016 Gabriel Gatu

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
