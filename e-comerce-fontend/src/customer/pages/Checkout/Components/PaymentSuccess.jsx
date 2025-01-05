import React from 'react';
import { Box, Button, Typography } from '@mui/material';
import CheckCircleIcon from '@mui/icons-material/CheckCircle';
import { formatPrice } from '../../../../utils';

const PaymentSuccess = ({ paymentDetails, onBackHome }) => {
  const { orderId, amount, paymentTime, transactionId, paymentMethod } = paymentDetails;

  return (
    <Box sx={{ textAlign: 'center' }}>
      <CheckCircleIcon sx={{ fontSize: "56px", color: "#22c55e" }} />
      <h3>PAYMENT SUCCESSFUL</h3>
      <Typography>
        Cảm ơn bạn đã đặt hàng. Đơn hàng của bạn sẽ sớm được xử lý
      </Typography>
      <Box sx={{ display: "flex", justifyContent: "space-between", mt: 2 }}>
        <p>Order ID: </p>
        <p>{orderId}</p>
      </Box>
      <Box sx={{ display: "flex", justifyContent: "space-between" }}>
        <p>Amount: </p>
        <p>{formatPrice(amount)}</p>
      </Box>
      <Box sx={{ display: "flex", justifyContent: "space-between" }}>
        <p>Payment Method: </p>
        <p>{paymentMethod}</p>
      </Box>
      {paymentMethod === 'VNPAY' && (
        <>
          <Box sx={{ display: "flex", justifyContent: "space-between" }}>
            <p>Payment Time: </p>
            <p>{paymentTime}</p>
          </Box>
          <Box sx={{ display: "flex", justifyContent: "space-between" }}>
            <p>Transaction ID: </p>
            <p>{transactionId}</p>
          </Box>
        </>
      )}
      <Button onClick={onBackHome} variant="contained" sx={{ mt: 2 }}>
        Quay về trang chủ
      </Button>
    </Box>
  );
};

export default PaymentSuccess;