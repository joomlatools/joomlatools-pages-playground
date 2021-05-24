<?php

if(function_exists('xdebug_disable')) { xdebug_disable(); }

define('KOOWA_ROOT'   , realpath(__DIR__));
define('KOOWA_VENDOR' , KOOWA_ROOT.'/vendor');

//Load composer
require_once KOOWA_VENDOR.'/autoload.php';

//Load Component
require_once KOOWA_VENDOR.'/joomlatools/framework/code/libraries/joomlatools/component/koowa/koowa.php';

//Load Framework
require_once KOOWA_VENDOR.'/joomlatools/framework/code/libraries/joomlatools/library/koowa.php';

Koowa::getInstance(array(
    'root_path'    => KOOWA_ROOT,
    'vendor_path'  => KOOWA_VENDOR,
));

//Bootstrap Framework
Koowa::getObject('object.bootstrapper')
    ->registerComponent('koowa', KOOWA_VENDOR.'/joomlatools/framework/code/libraries/joomlatools/component/koowa', 'koowa')
    ->registerComponent('pages', KOOWA_VENDOR.'/joomlatools/pages/code', 'koowa')
    ->bootstrap();

Koowa::getObject('event.publisher')->publishEvent('onAfterKoowaBootstrap');

//Dispatch Pages component
Koowa::getObject('com:pages.dispatcher.http')->dispatch();