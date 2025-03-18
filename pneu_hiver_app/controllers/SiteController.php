<?php

namespace app\controllers;

use Yii;
use yii\filters\AccessControl;
use yii\web\Controller;
use yii\web\Response;
use yii\filters\VerbFilter;
use app\models\LoginForm;
use app\models\ContactForm;

/**
 * SiteController is the default controller for the frontend application.
 */
class SiteController extends Controller
{
    /**
     * {@inheritdoc}
     */
    public function behaviors()
    {
        return [
            'access' => [
                'class' => AccessControl::class,
                'only' => ['logout'],
                'rules' => [
                    [
                        'actions' => ['logout'],
                        'allow' => true,
                        'roles' => ['@'],
                    ],
                ],
            ],
            'verbs' => [
                'class' => VerbFilter::class,
                'actions' => [
                    'logout' => ['post'],
                ],
            ],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function actions()
    {
        return [
            'error' => [
                'class' => 'yii\web\ErrorAction',
            ],
            'captcha' => [
                'class' => 'yii\captcha\CaptchaAction',
                'fixedVerifyCode' => YII_ENV_TEST ? 'testme' : null,
            ],
        ];
    }

    /**
     * Displays homepage.
     *
     * @return string
     */
    public function actionIndex()
    {
        return $this->render('index');
    }


    /**
     * Changes the language.
     *
     * @return Response the response object
     */
    public function actionChangeLanguage()
    {
        $language = Yii::$app->request->post('language');
        Yii::$app->session->set('language', $language);
        Yii::$app->language = $language;
        return $this->redirect(Yii::$app->request->referrer ?: Yii::$app->homeUrl);
    }

    /**
     * Sets the language before the action is executed.
     *
     * @param \yii\base\Action $action the action to be executed
     * @return bool whether the action should continue to be executed
     */
    public function beforeAction($action)
    {
        if (isset(Yii::$app->session['language'])) {
            Yii::$app->language = Yii::$app->session['language'];
        }
        return parent::beforeAction($action);
    }


}
