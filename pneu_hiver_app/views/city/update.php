<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;
use yii\helpers\ArrayHelper;
use app\models\Country;
use yii\helpers\Json;


$this->title = Yii::t('app','Update City');
$this->params['breadcrumbs'][] = ['label' => Yii::t('app','User City'), 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;


$countryJson = Json::encode($countries);
$this->registerJs("var countries = $countryJson;", $this::POS_HEAD);

?>

<h1><?= Html::encode($this->title) ?></h1>

<div class="city-form">
    <?php $form = ActiveForm::begin(); ?>

    <?= $form->field($city, 'countryid')->dropDownList(
        ArrayHelper::map($countries, 'id', 'name'),
        ['prompt' => Yii::t('app','Select Country')]
    ) ?>




    <?= $form->field($city, 'name')->textInput(['maxlength' => true]) ?>

    <?= $form->field($city, 'lat')->hiddenInput()->label(false) ?>

    <?= $form->field($city, 'lon')->hiddenInput()->label(false) ?>

    <div class="form-group">
        <?= Html::submitButton(Yii::t('app','Save'), ['class' => 'btn btn-primary']) ?>
    </div>

</div>

<?php

$jsFilePath = Yii::$app->request->baseUrl . '/js/geoComplete.js';
$this->registerJsFile($jsFilePath, ['depends' => [\yii\web\JqueryAsset::class]]);

?>

<?php ActiveForm::end(); ?>
