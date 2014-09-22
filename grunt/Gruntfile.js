module.exports = function(grunt) {
    // All configuration goes here
    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),

        // CONCAT FILES
        concat: {
            main: {
                src: [
                    'js/*.js'  // The big custom file!
                ],
                dest: 'build/js/custom.js'
            }
        },

        // UGLIFY FILES
        uglify: {
            main: {
                files: [{
                  expand: true,
                  cwd: 'js',
                  src: '**/*.js',
                  dest: '../public/js'
              }]
            }
        },

        // JSHINT
        jshint: {
            options: {
                reporter: require('jshint-stylish')
            },
            target: ['js/*.js']
        },

        // SASS
        sass: {
            dist: {
                options: {
                    style: 'compressed'
                },
                files: {
                    'build/css/custom.css': 'sass/custom.scss',
                }
            }
        },

        // AUTOPREFIXT
        autoprefixer: {
            dist: {
                src: 'build/css/*.css'
            }
        },

        // LEGACCSY
        legacssy: {
            dist: {
                files: {
                    'build/css/custom-legacy.css': 'build/css/custom.css'
                },
            }
        },

        // CSSMIN
        cssmin: {
            minify: {
                expand: true,
                cwd: 'build/css/',
                src: ['*.css', '!*.min.css'],
                dest: '../public/css/',
                ext: '.min.css'
            }
        },

        // NOTIFY
        notify: {
            css: {
                options: {
                    message: 'CSS task complete'
                }
            },
            js: {
                options: {
                    message: 'JS task complete'
                }
            }
        },

        // WATCH
        watch: {
            options: {
                livereload: false
            },
            js: {
                files: ['js/**/*.js'],
                tasks: ['js', 'notify:js'],
                options: {
                    spawn: false,
                },
            },
            css: {
                files: ['sass/**/*.scss'],
                tasks: ['css', 'notify:css'],
                options: {
                    spawn: false,
                }
            }
        }

    });

    // Where we tell Grunt we plan to use this plug-in.
    require('load-grunt-tasks')(grunt);

    // Where we tell Grunt what to do when we type "grunt" into the terminal.
    grunt.registerTask('default', ['build', 'watch']);
    grunt.registerTask('js', ['jshint', 'concat', 'uglify']);
    grunt.registerTask('css', ['sass', 'autoprefixer', 'legacssy', 'cssmin']);
    grunt.registerTask('build', ['css', 'js']);
};
