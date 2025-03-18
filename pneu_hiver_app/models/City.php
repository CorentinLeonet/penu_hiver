<?php

namespace app\models;

use Yii;
use yii\db\ActiveRecord;
use yii\helpers\Json;
use app\models\User;
use app\models\TempData;
use yii\db\Expression;

/**
 * City is the ActiveRecord model for the "city" table.
 */
class City extends ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'city';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['name'], 'required'],
            [['countryid'], 'required'],
            [['lat'], 'required'],
            [['lon'], 'required'],
            [['name'], 'string', 'max' => 255],

        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'name' => Yii::t('app', 'City'),
            'countryid' => Yii::t('app', 'Country'),
        ];
    }

    /**
     * Gets the country associated with the city.
     *
     * @return \yii\db\ActiveQuery the ActiveQuery instance
     */
    public function getCountry()
    {
        return $this->hasOne(Country::class, ['id' => 'countryid']);
    }

    /**
     * Fetches and saves weather data for the city.
     */
    public function fetchAndSaveWeatherData()
    {
        $tempData = new TempData();
        $tempData->cityid = $this->id;
        $apiKey = "YOUR_openweathermap_API_KEY_HERE";

        $lat = $this->lat;
        $long = $this->lon;

        
        $url = "https://api.openweathermap.org/data/2.5/weather?lat=".$lat."&lon=".$long."&units=metric&appid=".$apiKey;

        try {
            $response = file_get_contents($url);

            $data = Json::decode($response, true);

            if ($data['cod'] === 200) {
                // Extraire les coordonnées et la température actuelle de la réponse
                $temperature = $data['main']['temp'];
                $date = date('Y-m-d H:i:s');

                // Enregistrer la température et la date dans la base de données
                $tempData->temperature = $temperature;
                $tempData->date = $date;
                $tempData->save();
            }
            else {
                $errorMessage = Yii::t('app', 'Failed to fetch weather data for city ID: {id}', ['id' => $this->id]);
                Yii::error($errorMessage);
            }

        } catch (Exception $e) {
            Yii::error("Error on weather data reception : " . $e->getMessage());
        }
    }

    /**
     * Warns users if the average temperature for the city is below 7 degrees.
     */
    public function warnUsers(){
        // Récupérer les enregistrements de température des 3 derniers jours pour cette ville
        
        $recentTemperatures = TempData::find()
            ->where(['cityid' => $this->id])
            ->andWhere(['>=', 'date', new Expression('DATE_SUB(NOW(), INTERVAL 3 DAY)')])
            ->orderBy(['date' => SORT_DESC])
            ->all();

        if(count($recentTemperatures) > 0){

            // Calculer la température moyenne des trois derniers jours
            $totalTemperature = 0;
            foreach ($recentTemperatures as $temp) {
                $totalTemperature += $temp->temperature;
            }
            $averageTemperature = $totalTemperature / count($recentTemperatures);
        
        
            // Vérifier si la température moyenne est inférieure à 7 degrés
            if ($averageTemperature < 7) {
                // Envoyer un e-mail aux utilisateurs concernés
                
                $users = User::find()->where(['cityid' => $this->id])->all();
                foreach ($users as $user) {
                    $userModel = User::findOne($user['id']);
                    $userModel->sendWarningWinter();
                }

            }
            else{
				// Récupérer les enregistrements de température des 3 jours d'avant les 3 derniers jours pour cette ville
				// Dans le futur, un bool vérifiera si un mail a déjà été envoyé
                $oldTemperatures = TempData::find()
                    ->where(['cityid' => $this->id])
                    ->andWhere(['>=', 'date', new Expression('DATE_SUB(NOW(), INTERVAL 6 DAY)')])
                    ->andWhere(['<=', 'date', new Expression('DATE_SUB(NOW(), INTERVAL 3 DAY)')])
                    ->orderBy(['date' => SORT_DESC])
                    ->all();

                if(count($oldTemperatures)>0){
                    $totalTemperature = 0;
                    foreach ($oldTemperatures as $temp) {
                        $totalTemperature += $temp->temperature;
                    }
                    $averageOldTemperature = $totalTemperature / count($oldTemperatures);
                    // Vérifier si la température moyenne d'avant était inférieure à 7 degrés
                    if($averageOldTemperature < 7){
                        // Envoyer un e-mail aux utilisateurs concernés
                        $users = User::find()->where(['cityid' => $this->id])->all();
                        foreach ($users as $user) {
                            $userModel = User::findOne($user['id']);
                            $userModel->sendWarningSummer();
                        }  
                    }
                }
            }
        }

    }

}
