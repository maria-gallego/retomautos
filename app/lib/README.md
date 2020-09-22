# `app/lib` vs `/lib`

Why on earth do we have `app/lib`? Glad you asked...

- `/lib` is meant to be the place to put all application **independent**
  libraries that, for example, *could* be reused in multiple project or
  extracted into a gem.
- `/app/lib` is meant to be the place to put some libraries that
  **depend** on our current application.

Additionally, everything inside `app/` gets *autoloaded*, *eager loaded*
and *autoreloaded* in development following whatever configurations your
Rails project has, so any library that is considered subject to be part
of the active development of this project should go inside `app/lib`.

See
[this Stack Overflow thread](https://stackoverflow.com/a/40019108/4304753)
for more info.
