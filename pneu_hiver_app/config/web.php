<?php

$params = require __DIR__ . '/params.php';
$db = require __DIR__ . '/db.php';

$config = [
    'id' => 'basic',
    'basePath' => dirname(__DIR__),
    'bootstrap' => [
        'log',
        'queue',
    ],
    'aliases' => [
        '@bower' => '@vendor/bower-asset',
        '@npm'   => '@vendor/npm-asset',
    ],
    'components' => [
        'request' => [
            // !!! insert a secret key in the following (if it is empty) - this is required by cookie validation
            'cookieValidationKey' => 'qQjgcrm3YtgQdAPwlJLdvcBR9cyfWYFx',
        ],
        'cache' => [
            'class' => 'yii\caching\FileCache',
        ],
		'select2' => [
			'class' => 'kartik\select2\Select2',
			// Additional configuration options
		],
		/*
        'user' => [
            'identityClass' => 'app\models\User',
            'enableAutoLogin' => true,
        ],
		//*/
        'errorHandler' => [
            'errorAction' => 'site/error',
        ],
        'mailer' => [
            'class' => yii\symfonymailer\Mailer::class,
            'useFileTransport' => true,
        ],
        'log' => [
            'traceLevel' => YII_DEBUG ? 3 : 0,
            'targets' => [
                [
                    'class' => 'yii\log\FileTarget',
                    'levels' => ['error', 'warning'],
                ],
            ],
        ],
        'db' => $db,
		//*
		'authManager' => [
            'class' => 'yii\rbac\DbManager',
            // uncomment if you want to cache RBAC items hierarchy
            // 'cache' => 'cache',
        ],
		//*/
        //*
        'urlManager' => [
            'enablePrettyUrl' => true,
            'showScriptName' => false,
            'rules' => [
            ],
        ],
        //*/
        'queue' => [
            'class' => \yii\queue\db\Queue::class,
            'db' => 'db', 
            'tableName' => '{{%queue}}',
            'channel' => 'default', // Queue channel key
            'mutex' => \yii\mutex\MysqlMutex::class, // Mutex that used to sync queries
            'as log' => \yii\queue\LogBehavior::class,
        ],
        'cron' => [
            'class' => 'fedemotta\cronjob\CronjobComponent',
        ],
        'i18n' => [
            'translations' => [
                'app*' => [
                    'class' => 'yii\i18n\PhpMessageSource',
                    'basePath' => '@app/messages',
                    'sourceLanguage' => 'en',
                    'fileMap' => [
                        'app' => 'app.php',
                        'app/error' => 'error.php',
                    ],
                ],
            ],
        ],
    ],
    'params' => $params,
	//*
	'modules' => [
		'user' => [
			'class' => Da\User\Module::class,
            'classMap' => [
                'User' => app\models\User::class,
            ],
            'enableGdprCompliance' => true,
            'gdprPrivacyPolicyUrl' => 'https://example.com/privacy-policy',
            'allowAccountDelete' => true,
			// ...other configs from here: [Configuration Options](installation/configuration-options.md), e.g.
			// 'administrators' => ['admin'], // this is required for accessing administrative actions
			// 'generatePasswords' => true,
			// 'switchIdentitySessionKey' => 'myown_usuario_admin_user_key',
		]
	],
	//*/
];

if (YII_ENV_DEV) {
    // configuration adjustments for 'dev' environment
    $config['bootstrap'][] = 'debug';
    $config['modules']['debug'] = [
        'class' => 'yii\debug\Module',
        'panels' => [
            'queue' => \yii\queue\debug\Panel::class,
        ],
        // uncomment the following to add your IP if you are not connecting from localhost.
        //'allowedIPs' => ['127.0.0.1', '::1'],
    ];

    $config['bootstrap'][] = 'gii';
    $config['modules']['gii'] = [
        'class' => 'yii\gii\Module',
        // uncomment the following to add your IP if you are not connecting from localhost.
        //'allowedIPs' => ['127.0.0.1', '::1'],
    ];
}

return $config;
