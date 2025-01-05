import React, { useEffect, useState } from "react";
import { useLocation, useNavigate } from "react-router-dom";
import { Box } from "@mui/material";
import { useDispatch } from "react-redux";
import paymentApi from "../../../api/paymentApi";
import { removeCart } from "../../../app/CartSlice";
import PaymentSuccess from "./Components/PaymentSuccess";
import PaymentError from "./Components/PaymentError";

const PaymentResult = () => {
  const [paymentResult, setPaymentResult] = useState(null);
  const location = useLocation();
  const navigate = useNavigate();
  const dispatch = useDispatch();

  useEffect(() => {
    const processPayment = async () => {
      try {
        // Handle COD payment result from state
        if (location.state) {
          const { success, orderId, amount, paymentMethod, error } = location.state;
          if (success) {
            setPaymentResult({
              success: true,
              paymentDetails: {
                orderId,
                amount,
                paymentMethod
              }
            });
            dispatch(removeCart());
          } else {
            setPaymentResult({
              success: false,
              error
            });
          }
          return;
        }

        // Handle VNPAY payment result from URL params
        const params = new URLSearchParams(location.search);
        const response = await paymentApi.paymentResult(params.toString());
        
        if (response.paymentStatus === "success") {
          setPaymentResult({
            success: true,
            paymentDetails: {
              orderId: response.orderId,
              amount: response.totalPrice,
              paymentTime: response.paymentTime,
              transactionId: response.transactionId,
              paymentMethod: 'VNPAY'
            }
          });
          dispatch(removeCart());
        } else {
          setPaymentResult({
            success: false,
            error: response.message
          });
        }
      } catch (error) {
        console.error("Error processing payment result:", error);
        setPaymentResult({
          success: false,
          error: "Failed to process payment result"
        });
      }
    };

    processPayment();
  }, [location, dispatch]);

  const handleBackHome = () => {
    navigate("/");
  };

  const style = {
    position: "absolute",
    top: "50%",
    left: "50%",
    transform: "translate(-50%, -50%)",
    width: 450,
    bgcolor: "background.paper",
    border: "2px solid #000",
    boxShadow: 24,
    p: 4,
  };

  if (!paymentResult) {
    return <p>Processing payment...</p>;
  }

  return (
    <Box sx={style}>
      {paymentResult.success ? (
        <PaymentSuccess 
          paymentDetails={paymentResult.paymentDetails}
          onBackHome={handleBackHome}
        />
      ) : (
        <PaymentError 
          error={paymentResult.error}
          onBackHome={handleBackHome}
        />
      )}
    </Box>
  );
};

export default PaymentResult;