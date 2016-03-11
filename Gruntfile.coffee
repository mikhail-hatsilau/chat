module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    coffee:
      compile:
        files: [
          {
            './app.js': './app.coffee',
            './routes/index.js': './routes/index.coffee'
          },
          {
            expand: true
            cwd: 'src/javascripts/',
            src: ['**/*.coffee'],
            dest: 'public/javascripts/',
            ext: '.js',
            extDot: 'last'
          }
        ]
    sass:
      dist:
        files:
          './public/stylesheets/styles.css': './src/stylesheets/styles.sass'
      options:
        includePaths: [
          './bower_components/bourbon/app/assets/stylesheets/',
          './bower_components/mdi/scss'
        ]
    bower_concat:
      all:
        dest: 'public/javascripts/vendor/_bower.js'
        dependencies:
          'lumx': ['jquery', 'velocity', 'moment', 'angular']


  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-sass'
  grunt.loadNpmTasks 'grunt-bower-concat'


  grunt.registerTask 'default', ['coffee', 'sass', 'bower_concat']
