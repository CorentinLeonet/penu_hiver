<?php

namespace app\models;

use Yii;
use yii\db\ActiveRecord;

/**
 * Country is the model class for the "country" table.
 *
 * @property int $id
 * @property string $name
 */
class Country extends ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'country';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['name'], 'required'],
            [['name'], 'string', 'max' => 255],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'name' => Yii::t('app', 'Country Name'),
        ];
    }

}
