<?php

/** @var yii\web\View $this */
/** @var string $content */

use app\assets\AppAsset;
use app\widgets\Alert;
use yii\bootstrap5\Breadcrumbs;
use yii\bootstrap5\Html;
use yii\bootstrap5\Nav;
use yii\bootstrap5\NavBar;

AppAsset::register($this);

$this->registerCsrfMetaTags();
$this->registerMetaTag(['charset' => Yii::$app->charset], 'charset');
$this->registerMetaTag(['name' => 'viewport', 'content' => 'width=device-width, initial-scale=1, shrink-to-fit=no']);
$this->registerMetaTag(['name' => 'description', 'content' => $this->params['meta_description'] ?? '']);
$this->registerMetaTag(['name' => 'keywords', 'content' => $this->params['meta_keywords'] ?? '']);
$this->registerLinkTag(['rel' => 'icon', 'type' => 'image/x-icon', 'href' => Yii::getAlias('@web/favicon.ico')]);

$currentLanguage = Yii::$app->language;

$languages = [
    'en-US' => 'English',
    'fr' => 'Français',
    'nl' => 'Nederlands',
    'de' => 'Deutsch',
];
?>
<?php $this->beginPage() ?>
<!DOCTYPE html>
<html lang="<?= Yii::$app->language ?>" class="h-100">
<head>
    <title><?= Html::encode($this->title) ?></title>
    <?php $this->head() ?>
</head>
<body class="d-flex flex-column h-100">
<?php $this->beginBody() ?>


<header id="header">
    <?php
    NavBar::begin([
        'brandLabel' => Yii::$app->name,
        'brandUrl' => Yii::$app->homeUrl,
        'options' => ['class' => 'navbar-expand-md navbar-dark bg-dark fixed-top']
    ]);
	/**
	* J'ai changer la façon de faire de yii basic pour avoir plus facile à mettre des conditions
	*
	*/
    $menuItems = [
		['label' => Yii::t('app','Home'), 'url' => ['/site/index']],
	];

	if (Yii::$app->user->can("admin")) {
		$menuItems[] = ['label' => Yii::t('app','Users Management'), 'url' => ['/user/admin/index']];
        $menuItems[] = ['label' => Yii::t('app','City Management'), 'url' => ['/city/management']];
	}

    if (!Yii::$app->user->isGuest) {
		$menuItems[] = ['label' => Yii::t('app','My City'), 'url' => ['/city/index']];
        $menuItems[] = ['label' => Yii::t('app','My Profil'), 'url' => ['/user/settings/profile']];
	}

    

	$menuItems[] =  Yii::$app->user->isGuest
                ? ['label' => 'Login', 'url' => ['/user/login']]
                : '<li class="nav-item">'
                    . Html::beginForm(['/user/logout'])
                    . Html::submitButton(
                        'Logout (' . Yii::$app->user->identity->username . ')',
                        ['class' => 'nav-link btn btn-link logout']
                    )
                    . Html::endForm()
                    . '</li>';

    //Changement de langue
    $menuItems[] = '<li class="nav-item">' .
    Html::beginForm([Yii::$app->urlManager->createUrl(['/site/change-language'])], 'post', ['class' => 'nav-link'])
    . Html::dropDownList('language', Yii::$app->session->get('language', $currentLanguage), $languages, ['class' => 'form-select', 'onchange' => 'this.form.submit()'])
    . Html::endForm()
    . '</li>';

	echo Nav::widget([
		'options' => ['class' => 'navbar-nav'],
		'items' => $menuItems,
	]);
	//
    NavBar::end();
    ?>
</header>

<main id="main" class="flex-shrink-0" role="main">
    <div class="container">
        <?php if (!empty($this->params['breadcrumbs'])): ?>
            <?= Breadcrumbs::widget(['links' => $this->params['breadcrumbs']]) ?>
        <?php endif ?>
        <?= Alert::widget() ?>
        <?= $content ?>
    </div>
</main>

<footer id="footer" class="mt-auto py-3 bg-light">
    <div class="container">
        <div class="row text-muted">
            <div class="col-md-6 text-center text-md-start">&copy; IEPS-Marche <?= date('Y') ?></div>
            <div class="col-md-6 text-center text-md-end"><?= Yii::powered() ?></div>
        </div>
    </div>
</footer>

<?php $this->endBody() ?>
</body>
</html>
<?php $this->endPage() ?>
