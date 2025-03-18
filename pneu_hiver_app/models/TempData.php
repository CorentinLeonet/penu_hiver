<?php

namespace app\models;

use Yii;
use yii\db\ActiveRecord;

/**
 * TempData is the model class for the "temp_data" table.
 *
 * @property int $id
 * @property float $temperature
 * @property int $cityid
 * @property string $date
 *
 * @property-read City $city
 */
class TempData extends ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'temp_data';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['temperature'], 'required'],
            [['cityid'], 'required'],
            [['date'], 'required'],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'temperature' => Yii::t('app', 'Temperature'),
            'cityid' => Yii::t('app','City'),
            'date' => Yii::t('app','Date')
        ];
    }

    /**
     * Gets the city associated with the temperature data.
     *
     * @return \yii\db\ActiveQuery
     */
    public function getCity()
    {
        return $this->hasOne(City::class, ['id' => 'cityid']);
    }


}
