<?php

namespace app\controllers;

use Yii;
use yii\web\Controller;
use yii\filters\AccessControl;
use app\models\City;
use app\models\Country;
use app\models\TempData;
use yii\data\ActiveDataProvider;

/**
 * CityController implements the CRUD actions for City model.
 */
class CityController extends Controller
{
    public function behaviors()
    {
        return [
            'access' => [
                'class' => AccessControl::className(),
                'rules' => [
                    [
                        'allow' => true,
                        'roles' => ['@'],
                    ],
                ],
            ],
        ];
    }

    /**
     * Lists all cities for the current user.
     *
     * @return string|\yii\web\Response the rendering result or a redirect response if the user does not have a city assigned
     */
    public function actionIndex()
    {
        $user = Yii::$app->getUser()->getIdentity();
        $userCity = $user->city;
        $tempDatas = TempData::find()->where(['cityid' => $userCity])->all();

        if ($userCity === null) {
            return $this->redirect(['create']);
        }
    
        return $this->render('index', [
            'city' => $userCity,
            'tempDatas' => $tempDatas,
        ]);
    }

    /**
     * Displays a single city.
     *
     * @param int $id the ID of the city
     * @return string the rendering result
     * @throws \yii\web\NotFoundHttpException if the city is not found
     */
    public function actionView($id)
    {
        $city = City::findOne($id);
        $tempDatas = TempData::find()->where(['cityid' => $city])->all();
    
        return $this->render('view', [
            'city' => $city,
            'tempDatas' => $tempDatas,
        ]);
    }


    /**
     * Creates a new city.
     *
     * @return string|\yii\web\Response the rendering result or a redirect response if the city is successfully created
     */
    public function actionCreate()
    {
        $city = new City();
        $countries = Country::find()->all();
        
        if ($city->load(Yii::$app->request->post())) {
            // Vérifier si la ville existe déjà
            $existingCity = City::find()->where(['name' => $city->name])->one();
            
            if ($existingCity) {
                // La ville existe déjà, lier l'utilisateur à la ville existante
                $user = Yii::$app->user->identity;
                $user->cityid = $existingCity->id;
                
                if ($user->save()) {
                    // L'utilisateur a été enregistré avec succès avec la ville existante
                    return $this->redirect(['index']);
                } else {
                    // Possibilité de gérer les erreurs de sauvegarde de l'utilisateur
                }
            } else {
                // La ville n'existe pas, continuer avec la logique existante
                if ($city->save()) {
                    // La ville a été enregistrée avec succès
                    return $this->redirect(['index']);
                } else {
                    // Possibilité de gérer les erreurs de sauvegarde de la nouvelle ville
                }
            }
        }

        return $this->render('create', [
            'city' => $city,
            'countries' => $countries,
        ]);
    }

    /**
     * Updates an existing city.
     *
     * @param int $id the ID of the city to be updated
     * @return string|\yii\web\Response the rendering result or a redirect response if the city is successfully updated
     * @throws \yii\web\NotFoundHttpException if the city is not found
     */
    public function actionUpdate($id)
    {
        $city = City::findOne($id);
        $countries = Country::find()->all();

        if ($city->load(Yii::$app->request->post())) {
            // Vérifier si la ville existe déjà
            $existingCity = City::find()->where(['name' => $city->name])->one();
            
            if ($existingCity) {
                // La ville existe déjà, lier l'utilisateur à la ville existante
                $user = Yii::$app->user->identity;
                $user->cityid = $existingCity->id;
                
                if ($user->save()) {
                    // L'utilisateur a été enregistré avec succès avec la ville existante
                    return $this->redirect(['index']);
                } else {
                    // Possibilité de gérer les erreurs de sauvegarde de l'utilisateur
                }
            } else {
                // La ville n'existe pas
                $newCity = new City();
                $newCity->name = $city->name;
                $newCity->countryid = $city->countryid;
                $newCity->lat = $city->lat;
                $newCity->lon = $city->lon;
                
                if ($newCity->save()) {
                    // Nouvelle ville enregistrée avec succès, lier l'utilisateur à la nouvelle ville
                    $user = Yii::$app->user->identity;
                    $user->cityid = $newCity->id;
                    
                    if ($user->save()) {
                        // L'utilisateur a été enregistré avec succès avec la nouvelle ville
                        return $this->redirect(['view', 'id' => $newCity->id]);
                    } else {
                        // Possibilité de gérer les erreurs de sauvegarde de l'utilisateur
                    }
                } else {
                    // Possibilité de gérer les erreurs de sauvegarde de la nouvelle ville
                }
            }
        }

        return $this->render('update', [
            'city' => $city,
            'countries' => $countries,
        ]);
    }

    /**
     * Displays the city management page.
     *
     * @return string the rendering result
     * @throws \yii\web\ForbiddenHttpException if the user is not authorized to access this page
     */
    public function actionManagement()
    {
        //Vérifier si l'user est admin
        if (!Yii::$app->user->can('admin')) {
            throw new \yii\web\ForbiddenHttpException('You are not allowed to access this page.');
        }
        
        //Gérer les données
        $dataProvider = new ActiveDataProvider([
            'query' => City::find(),
            'pagination' => [
                'pageSize' => 20, // Nombre de villes par page
            ],
        ]);
        
        return $this->render('management', [
            'dataProvider' => $dataProvider,
        ]);
    }

    /**
     * Sets the language before the action is executed.
     *
     * @param \yii\base\Action $action the action to be executed
     * @return bool whether the action should continue to be executed
     */
    public function beforeAction($action)
    {
        if ($language = Yii::$app->session->get('language')) {
            Yii::$app->language = $language;
        }
        return parent::beforeAction($action);
    }


}
