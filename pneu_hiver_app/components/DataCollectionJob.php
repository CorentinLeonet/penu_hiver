<?php
namespace app\components;

use Yii;
use yii\base\BaseObject;
use yii\queue\JobInterface;
use app\models\City;
use app\models\CollectStatus;

/**
 * DataCollectionJob is a job class for collecting and processing weather data for cities.
 *
 * This job performs a custom query to fetch a list of cities joined with users and performs
 * weather data collection and warning actions for each city.
 *
 * @property-read string $execute
 */
class DataCollectionJob extends BaseObject implements JobInterface
{
    /**
     * Executes the data collection job.
     *
     * This method is called by the queue worker when executing the job.
     *
     * @param \yii\queue\Queue $queue the queue that the job belongs to
     */
    public function execute($queue)
    {
        // Requête personnalisée avec jointure
        $queryCities = Yii::$app->db->createCommand('
            SELECT city.id, city.name
            FROM city
            JOIN user ON user.cityid = city.id
            GROUP BY city.id, city.name
        ');

        $cities = $queryCities->queryAll();

        foreach ($cities as $city) {
            $cityModel = City::findOne($city['id']);
            $cityModel->fetchAndSaveWeatherData();
            $cityModel->warnUsers();
        } 

    }  

}

