<?php
namespace app\controllers;

use Yii;
use yii\web\Controller;
use app\models\CollectStatus;
use app\components\DataCollectionJob;

/**
 * DataCollectionController implements the actions for data collection.
 */
class DataCollectionController extends Controller
{
    /**
     * Starts the data collection job.
     */
    public function actionStartJob()
    {
        $queue = Yii::$app->queue;
        
        // Ajouter la tâche de collecte de données à la file d'attente
        $collectStatus = CollectStatus::findOne(1);
        if($collectStatus){
            $queue->clear();
            $queue->push(new DataCollectionJob());

            $queue->run();
        }

    }

    /**
     * Adds the data collection job to the queue.
     */
    public function actionCollect()
    {
        $queue = Yii::$app->queue;
        $queue->push(new DataCollectionJob());

    }

    /**
     * Starts the data collection scheduler.
     */
    public function actionStartScheduler()
    {
        // Ajouter la tâche de collecte de données à la file d'attente
        $collectStatus = CollectStatus::findOne(1);
        $collectStatus->status = true;
        $collectStatus->save();
        

        $Status = true;

    }

    /**
     * Stops the data collection scheduler.
     */
    public function actionStopScheduler()
    {
        $collectStatus = CollectStatus::findOne(1);
        $collectStatus->status = false;
        $collectStatus->save();
    }

    /**
     * Fetches the status of the data collection task.
     *
     * @return string the JSON-encoded status
     */
    public function actionFetchStatus()
    {
        $collectStatus = CollectStatus::findOne(1);

        return json_encode(['status' => $collectStatus->status]);
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