es = require 'ecstatic'
http = require 'http'
gulp = require 'gulp'
jade = require 'gulp-jade'
csso = require 'gulp-csso'
stylus = require 'gulp-stylus'
reload = require 'gulp-livereload'
coffee = require 'gulp-coffee'
prefix = require 'gulp-autoprefixer'
uglify = require 'gulp-uglify'
autowatch = require 'gulp-autowatch'

nib = require 'nib'
rimraf = require 'rimraf'

paths =
  stylus: './src/css/**/*.styl'
  jade: './src/jade/**/*.jade'
  coffee: './src/js/*.coffee'
  js: './src/js/vendor/*.js'
  img: './src/img/**/*'
  fonts: './src/fonts/**/*'
src =
  stylus: './src/css/main.styl'
  jade: './src/jade/index.jade'

gulp.task 'stylus', ->
  gulp.src src.stylus
    .pipe stylus
      errors: true
      use: [nib()]
    .pipe prefix
      browsers: ['last 4 versions']
    .pipe csso()
    .pipe gulp.dest './build/css'
    .pipe reload()

gulp.task 'jade', ->
  gulp.src src.jade
    .pipe jade()
    .pipe gulp.dest './'
    .pipe reload()

gulp.task 'coffee', ->
  gulp.src paths.coffee
    .pipe coffee()
    .pipe uglify()
    .pipe gulp.dest './build/js'
    .pipe reload()

gulp.task 'js', ->
  gulp.src paths.js
    .pipe uglify()
    .pipe gulp.dest './build/js'
    .pipe reload()

gulp.task 'img', ->
  gulp.src paths.img
    .pipe gulp.dest './build/img'
    .pipe reload()

gulp.task 'fonts', ->
  gulp.src paths.fonts
    .pipe gulp.dest './build/fonts'
    .pipe reload()

gulp.task 'rimraf', (cb) ->
  rimraf 'build', cb

gulp.task 'server', (done) ->
  port = 5000
  server = http.createServer es root: './'
  server.listen port, done
  console.log "Server starting on port: #{port}"

gulp.task 'watch', (cb) ->
  reload.listen()
  autowatch gulp, paths
  cb()

gulp.task 'build', gulp.parallel Object.keys paths
gulp.task 'default', gulp.series 'rimraf', 'server', 'watch', 'build'
