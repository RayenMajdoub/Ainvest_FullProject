const Stripe = require('stripe');

const stripe = new Stripe(
  'sk_test_51MsHMUIBSeN5Gfw48LWzMBSqwNzhD7SpNpz7sTapJdUbetzMvL9RDHzL4M2AA0nWuJQAatpzsPK3iXGkNHWMtyIr00XqyvrovZ'
);

exports.payement = async (req, res) => {
  const customer = await stripe.customers.create();
  const ephemeralKey = await stripe.ephemeralKeys.create(
    { customer: customer.id },
    { apiVersion: '2020-08-27' }
  );
  const amount_number = Math.round(19.99 * 100);
  const paymentIntent = await stripe.paymentIntents.create({
    amount: amount_number,
    currency: 'eur',
    customer: customer.id,
    automatic_payment_methods: {
      enabled: true,
    },
  });

  res.json({
    paymentIntent: paymentIntent.client_secret,
    ephemeralKey: ephemeralKey.secret,
    customer: customer.id,
    publishableKey:
      'pk_test_51MsHMUIBSeN5Gfw4WDwlU1dmiFmpyCLT11GVtA8AGmt27PKhRY1nj33FGMsH2dfCuwT4nPBjhBMbOBvgJKv8mKGe00T8j2Qaoo',
  });
};
