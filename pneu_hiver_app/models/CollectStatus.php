<?php

namespace app\models;

use Yii;
use yii\db\ActiveRecord;

/**
 * CollectStatus represents the model for the 'collect_status' table.
 *
 * @property int $id
 * @property string $status
 *
 */
class CollectStatus extends ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'collect_status';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['status'], 'required']
        ];
    }


}
