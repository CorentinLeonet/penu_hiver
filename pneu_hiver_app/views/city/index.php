<?php

use yii\helpers\Html;
use yii\grid\GridView;
use yii\data\ArrayDataProvider;


$this->title = Yii::t('app','My City');
$this->params['breadcrumbs'][] = $this->title;
?>

<h1><?= Html::encode($this->title) ?></h1>

<div>
<p><?=Yii::t('app','Country')?> : <?= $city->country->name ?></p>
    <p><?=Yii::t('app','City')?> : <?= $city->name ?></p>
    
    <div class="tempdata-grid">
        <?= GridView::widget([
            'dataProvider' => new ArrayDataProvider([
                'allModels' => $tempDatas,
            ]),
            'columns' => [
                'temperature',
                'date',
            ],
        ]); ?>
    </div>

    <div>
        <?= Html::a(Yii::t('app','Change'), ['update', 'id' => $city->id], ['class' => 'btn btn-primary']) ?>
    </div>
</div>

