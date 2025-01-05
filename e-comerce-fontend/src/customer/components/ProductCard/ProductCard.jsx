import React from "react";
import PropTypes from "prop-types";
import { THUMBNAIL_PLACEHOLDER } from "../../../constants";
import { useNavigate } from "react-router-dom";
import { formatPrice } from "../../../utils";
import { Card } from "react-bootstrap";
import FavoriteBorderIcon from "@mui/icons-material/FavoriteBorder";
import { IconButton } from "@mui/material";
import useFavorites from "../../../hooks/useFavorites";

ProductCard.propTypes = {
  product: PropTypes.object.isRequired,
};

function ProductCard({ product }) {
  const navigate = useNavigate();
  const { toggleFavorite, isFavorite } = useFavorites();
  const thumbnailUrl = product.imageUrl || THUMBNAIL_PLACEHOLDER;

  const handleProductClick = () => {
    navigate(`/products/${product.id}`);
  };

  const handleClickFavorite = (e) => {
    e.stopPropagation();
    toggleFavorite(product);
  };

  return (
    <Card
      style={{
        width: "13.5rem",
        height: "25.5rem",
        marginBottom: "10px",
        cursor: "pointer",
      }}
      onClick={handleProductClick}
    >
      <div className="card-image">
        <Card.Link className="card-product">
          <Card.Img variant="top" src={thumbnailUrl} />
        </Card.Link>
      </div>
      <Card.Body>
        <Card.Text className="card-trademark">{product.brand}</Card.Text>
        <Card.Title>{product.productName}</Card.Title>
        <div className="card-price">
          <Card.Text className="card__text-price">
            {formatPrice(product.discountedPrice)}
          </Card.Text>
          <Card.Text className="card__text-cost">
            {formatPrice(product.price)}
          </Card.Text>
        </div>
        <IconButton onClick={handleClickFavorite}>
          <FavoriteBorderIcon
            style={{ color: isFavorite(product.id) ? "red" : "inherit" }}
          />
        </IconButton>
      </Card.Body>
    </Card>
  );
}

export default ProductCard;