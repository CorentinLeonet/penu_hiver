<?php

namespace app\models;

use Yii;
use yii\db\ActiveRecord;
use Da\User\Model\User as BaseUser;
use yii\swiftmailer\Mailer;
use yii\swiftmailer\Message;

/**
 * User is the model class for the user table.
 *
 * @property int $id
 * @property string $email
 * @property int $cityid
 *
 * @property-read City $city
 */
class User extends BaseUser
{
	/**
     * {@inheritdoc}
     */
	public function rules()
	{
		$rules = parent::rules();
        $rules[] = [['cityid'], 'integer'];
        return $rules;
	}

    /**
     * Gets the city associated with the user.
     *
     * @return \yii\db\ActiveQuery
     */
	public function getCity()
    {
        return $this->hasOne(City::class, ['id' => 'cityid']);
    }

    
    /**
     * Sends a warning email to the user.
     */
    public function sendWarningWinter(){
        Yii::$app->mailer->compose()
            ->setFrom('from@domain.com')
            ->setTo($this->email)
            ->setSubject(Yii::t('app','Tire change warning'))
            ->setTextBody(Yii::t('app','
                Hello,
                The average temperature for the last three days is below 7 degrees.
                According to Belgian law, it is necessary to change tires.
            '))
            ->send();
    }

    /**
     * Sends a warning email to the user.
     */
    public function sendWarningSummer(){
        Yii::$app->mailer->compose()
            ->setFrom('from@domain.com')
            ->setTo($this->email)
            ->setSubject(Yii::t('app','Tire change warning'))
            ->setTextBody(Yii::t('app','
                Hello,
                The average temperature for the last three days is above 7 degrees.
                According to Belgian law, it is necessary to change tires.
            '))
            ->send();
    }
}
