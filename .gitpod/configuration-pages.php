<?php

//@todo this path should be dynamically set by ENVs
return array(
    'sites' => [
        '[*]' => getenv('GITPOD_REPO_ROOT') . '/joomlatools-pages',
    ],
);