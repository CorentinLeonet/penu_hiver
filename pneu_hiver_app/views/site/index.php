<?php

/** @var yii\web\View $this */

$this->title = 'Pneus Hiver';
?>
<div class="site-index">

    <div class="jumbotron text-center bg-transparent mt-5 mb-5">
        <h1 class="display-4">Pneus Hiver!</h1>

        <p class="lead"><?= Yii::t('app','Welcome on Pneus Hiver.') ?></p>
    </div>

    <div class="body-content">

        <div class="row">
                <h2><?= Yii::t('app', 'What is it ?') ?></h2>

                <p><?= Yii::t('app','Pneus hiver is a web application that can send warning emails to registered users if the temperature drops below the temperature set by the country law for switching to winter tyres.') ?></p>

    </div>
</div>
