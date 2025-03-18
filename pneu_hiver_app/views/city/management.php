<?php

use yii\helpers\Html;
use yii\grid\GridView;
use yii\data\ActiveDataProvider;
use yii\grid\ActionColumn;
use yii\web\YiiAsset;



$this->title = Yii::t('app','City Management');
$this->params['breadcrumbs'][] = $this->title;

$this->registerJsFile('@web/js/collectData.js', ['depends' => [YiiAsset::class]])

?>

<h1><?= Html::encode($this->title) ?></h1>

<div class="form-check form-switch d-flex justify-content-end">
    <label class="form-check-label me-2" for="flexSwitchCheckDefault"><?= Yii::t('app','Collect data :')?></label>
    <input id="data-collection-toggle" class="form-check-input m-1" type="checkbox" role="switch">
</div>


<div class="tempdata-grid">
    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'columns' => [
            'name',
            [
                'attribute' => 'country.name',
                'label' => Yii::t('app','Country'),
            ],
            [
                'class' => 'yii\grid\ActionColumn',
                'template' => '{view}',
                'buttons' => [
                    'view' => function ($url, $city) {
                        return Html::a('View', ['view', 'id' => $city->id], ['class' => 'btn btn-primary']);
                    },
                ],
            ],
        ],
    ]) ?>
</div>

<?= Html::button(Yii::t('app','Collect now !'), ['id' => 'recolt_now', 'class' => 'btn btn-warning']) ?>
