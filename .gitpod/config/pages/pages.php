<?php

return array(

    //Use /site directory instead of default /joomlatools-pages
    'sites' => [
        '[*]' => KOOWA_ROOT.'/site',
    ],

    //Alias debugger assets to use joomlatools CDN
    'aliases' => [
        'media://koowa/framework/css/debugger.css' => 'https://files.joomlatools.com/joomlatools-framework@3.5.0/resources/assets/css/debugger.min.css',
        'media://koowa/framework/js/debugger.js' => 'https://files.joomlatools.com/joomlatools-framework@3.5.0/resources/assets/js/debugger.min.js',
    ],
);