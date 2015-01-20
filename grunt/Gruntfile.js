module.exports = function(grunt) {
    // Grunt options
    var target = grunt.option('target') || '../public/asphalt';

    var uglifyTargets = {
        main: {},
        polyfill: {},
        jquery: {},
        modernizr: {}
    };
    uglifyTargets['main'][target + '/js/main.min.js'] = ['build/js/main.js'];
    uglifyTargets['polyfill'][target + '/js/polyfill.min.js'] = ['build/js/polyfill.js'];
    uglifyTargets['jquery'][target + '/js/jquery.min.js'] = ['build/js/jquery.js'];

    // All configuration goes here
    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),


        // CONCAT FILES
        concat: {
            main: {
                src: [
                    'js/libs/*.js', // All JS in the libs folder
                    'js/libs/bootstrap/*.js', // All JS in the bootstrap folder
                    '!js/bootstrap/excludes/*', // Exclude some of the bootstrap files
                    'js/components/*.js', // All JS in the components folder
                    'js/main.js'  // The big main file!
                ],
                dest: 'build/js/main.js'
            },
            polyfill: {
                src: [
                    'js/polyfill/*.js' // All JS in the polyfill folder
                ],
                dest: 'build/js/polyfill.js'
            },
            jquery: {
                src: [
                    'js/jquery.js',
                    'js/jquery-ui.js'
                ],
                dest: 'build/js/jquery.js'
            }
        },

        // // UGLIFY FILES
        uglify: {
            main: {
                files: uglifyTargets['main']
            },
            polyfill: {
                files: uglifyTargets['polyfill']
            },
            jquery: {
                files: uglifyTargets['jquery']
            },
            singles: {
                files: [{
                  expand: true,
                  cwd: 'js/singles',
                  src: '**/*.js',
                  dest: target + '/js/singles'
              }]
            }
        },

        // JSHINT
        jshint: {
            options: {
                reporter: require('jshint-stylish'),
                ignores: ['js/jquery.js', 'js/jquery-ui.js', 'js/jquery.imgareaselect.pack.js']
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
                    'build/css/main.css': 'sass/main.scss',
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
                    'build/css/main-legacy.css': 'main/css/custom.css',
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
                dest: '../public/asphalt/css/',
                ext: '.min.css'
            }
        },

        // IMAGEMIN
        imagemin: {
            dynamic: {
                options: {
                    pngquant: true,
                    force: true
                },
                files: [{
                    expand: true,
                    cwd: 'img/',
                    src: ['**/*.{png,jpg,gif}'],
                    dest: 'build/img/'
                }]
            }
        },

        // SVGMIN
        svgmin: {
            options: {
                plugins: [
                  { removeViewBox: false },
                  { removeUselessStrokeAndFill: false }
                ]
            },
            dist: {
                files: [{
                    expand: true,
                    cwd: 'img/svg',
                    src: ['**/*.svg'],
                    dest: 'build/img/svg/'
                }]
            }
        },

        // SVG2PNG
        svg2png: {
            all: {
                // specify files in array format with multiple src-dest mapping
                files: [
                    // rasterize all SVG files in "img" and its subdirectories to "img/png"
                    {
                        src: ['img/**/*.svg'],
                        dest: 'img/svg/fallback/'
                    }
                ]
            }
        },

        // CLEAN
        clean: {
            img: {
                src: ['build/img', target + '/img']
            },
            options: {
                'force': true
            }
        },

        // COPY
        copy: {
            images: {
                cwd: 'build/img/',
                src: '**/*.*',
                expand: true,
                dest: target + '/img',
                filter: 'isFile'
            },
            fonts: {
                src: 'fonts/*',
                dest: target + '/'
            },
            svgs: {
                cwd: 'build/img/svg',
                src: '**/*.*',
                expand: true,
                dest: target + '/img/svg',
                filter: 'isFile'
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
            },
            img: {
                options: {
                    message: 'IMG task complete'
                }
            },
            svg: {
                options: {
                    message: 'SVG task complete'
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
            },
            images: {
                files: ['img/**/*.{png,jpg,gif,ico}'],
                tasks: ['img', 'notify:img']
            },
            fonts: {
                files: ['fonts/**'],
                tasks: ['fonts']
            }
        }

    });

    // Where we tell Grunt we plan to use this plug-in.
    require('load-grunt-tasks')(grunt);

    // Where we tell Grunt what to do when we type "grunt" into the terminal.
    grunt.registerTask('default', ['build', 'watch']);
    grunt.registerTask('js', ['jshint', 'concat', 'uglify']);
    grunt.registerTask('css', ['sass', 'autoprefixer', 'legacssy', 'cssmin']);
    grunt.registerTask('img', ['clean:img', 'imagemin', 'svg2png', 'svgmin', 'copy:images', 'copy:svgs']);
    grunt.registerTask('fonts', ['copy:fonts']);
    grunt.registerTask('build', ['css', 'js']);
};
