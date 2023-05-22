import mongoose from 'mongoose';
const { Schema, model } = mongoose;

const immobilierSchema = new Schema(
    {
        Nom: {
            type: String,
            required: true
        },
        TypeLocal: {
            type: Schema.Types.Mixed,
            required: true
        },
        adresse : {
            type: String,
           required: true
        },
        TypePro: {
            type: Schema.Types.Mixed,
            required: true
        },
    },
    {
        timestamps: true 
    }
);

export default model('Immobiliers', immobilierSchema);