// Enhanced Product Cards JavaScript

// Initialize when DOM is loaded
document.addEventListener('DOMContentLoaded', function() {
    initializeProductCards();
    setupScrollAnimations();
    setupImageLazyLoading();
});

// Initialize product card interactions
function initializeProductCards() {
    const productCards = document.querySelectorAll('.product-card');
    
    productCards.forEach((card, index) => {
        // Add staggered animation delay
        card.style.animationDelay = `${index * 0.1}s`;
        
        // Setup hover interactions
        setupCardHover(card);
        
        // Setup rating interactions
        setupRatingDisplay(card);
    });
}

// Setup card hover effects
function setupCardHover(card) {
    const image = card.querySelector('.product-image');
    const overlay = card.querySelector('.quick-view-overlay');
    const badge = card.querySelector('.product-badge');
    
    card.addEventListener('mouseenter', function() {
        // Add parallax effect to image
        if (image) {
            image.style.transform = 'scale(1.1) translateZ(0)';
        }
        
        // Show overlay with animation
        if (overlay) {
            overlay.style.opacity = '1';
            overlay.style.visibility = 'visible';
        }
        
        // Animate badge
        if (badge) {
            badge.style.opacity = '1';
            badge.style.transform = 'translateY(0)';
        }
    });
    
    card.addEventListener('mouseleave', function() {
        // Reset image transform
        if (image) {
            image.style.transform = 'scale(1) translateZ(0)';
        }
        
        // Hide overlay
        if (overlay) {
            overlay.style.opacity = '0';
            overlay.style.visibility = 'hidden';
        }
        
        // Reset badge
        if (badge) {
            badge.style.opacity = '0';
            badge.style.transform = 'translateY(-10px)';
        }
    });
}

// Setup rating display animations
function setupRatingDisplay(card) {
    const stars = card.querySelectorAll('.stars i');
    const ratingText = card.querySelector('.rating-text');
    
    // Animate stars on card hover
    card.addEventListener('mouseenter', function() {
        stars.forEach((star, index) => {
            setTimeout(() => {
                star.style.transform = 'scale(1.1) rotate(5deg)';
                star.style.color = '#ffd700';
            }, index * 50);
        });
        
        if (ratingText) {
            ratingText.style.color = '#667eea';
            ratingText.style.fontWeight = '600';
        }
    });
    
    card.addEventListener('mouseleave', function() {
        stars.forEach((star) => {
            star.style.transform = 'scale(1) rotate(0deg)';
        });
        
        if (ratingText) {
            ratingText.style.color = '#95a5a6';
            ratingText.style.fontWeight = '400';
        }
    });
}

// Setup scroll animations
function setupScrollAnimations() {
    const observerOptions = {
        root: null,
        rootMargin: '0px',
        threshold: 0.1
    };
    
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('animate-in');
                
                // Stagger animation for product cards in the same section
                const cards = entry.target.querySelectorAll('.product-card');
                cards.forEach((card, index) => {
                    setTimeout(() => {
                        card.classList.add('visible');
                    }, index * 100);
                });
            }
        });
    }, observerOptions);
    
    // Observe section headers and product containers
    const sections = document.querySelectorAll('.section-header, .row');
    sections.forEach(section => {
        observer.observe(section);
    });
}

// Setup lazy loading for images
function setupImageLazyLoading() {
    const images = document.querySelectorAll('.product-image');
    
    const imageObserver = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                const img = entry.target;
                
                // Add loading effect
                img.style.opacity = '0';
                img.style.transition = 'opacity 0.3s ease';
                
                // Simulate loading
                setTimeout(() => {
                    img.style.opacity = '1';
                    img.classList.add('loaded');
                }, 200);
                
                imageObserver.unobserve(img);
            }
        });
    });
    
    images.forEach(img => {
        imageObserver.observe(img);
    });
}

// Enhanced product card click handler
function handleProductClick(productId) {
    // Add click animation
    const productCard = event.target.closest('.product-card');
    if (productCard) {
        productCard.style.transform = 'scale(0.98)';
        setTimeout(() => {
            productCard.style.transform = '';
            window.location.href = `detail?pid=${productId}`;
        }, 100);
    }
}

// Enhanced load more functionality
function enhancedLoadMore(type, buttonElement) {
    // Add loading state to button
    const originalText = buttonElement.innerHTML;
    buttonElement.innerHTML = '<i class="fas fa-spinner fa-spin mr-2"></i>Đang tải...';
    buttonElement.disabled = true;
    
    // Call original load more function
    switch(type) {
        case 'nike':
            loadMoreNike();
            break;
        case 'adidas':
            loadMoreAdidas();
            break;
        default:
            loadMore();
    }
    
    // Reset button after delay
    setTimeout(() => {
        buttonElement.innerHTML = originalText;
        buttonElement.disabled = false;
        
        // Initialize new cards
        initializeProductCards();
    }, 1000);
}

// Add smooth scrolling to sections
function scrollToSection(sectionId) {
    const section = document.getElementById(sectionId);
    if (section) {
        section.scrollIntoView({
            behavior: 'smooth',
            block: 'start'
        });
    }
}

// Add product to favorites (placeholder function)
function addToFavorites(productId) {
    // Show notification
    showNotification('Đã thêm vào danh sách yêu thích!', 'success');
    
    // Add visual feedback
    const heartIcon = event.target;
    heartIcon.classList.add('text-danger');
    heartIcon.style.transform = 'scale(1.2)';
    
    setTimeout(() => {
        heartIcon.style.transform = 'scale(1)';
    }, 200);
}

// Show notification function
function showNotification(message, type = 'info') {
    // Create notification element
    const notification = document.createElement('div');
    notification.className = `alert alert-${type} notification-toast`;
    notification.style.cssText = `
        position: fixed;
        top: 20px;
        right: 20px;
        z-index: 9999;
        min-width: 300px;
        opacity: 0;
        transform: translateX(100%);
        transition: all 0.3s ease;
    `;
    notification.innerHTML = `
        <i class="fas fa-check-circle mr-2"></i>
        ${message}
        <button type="button" class="close" onclick="this.parentElement.remove()">
            <span>&times;</span>
        </button>
    `;
    
    document.body.appendChild(notification);
    
    // Animate in
    setTimeout(() => {
        notification.style.opacity = '1';
        notification.style.transform = 'translateX(0)';
    }, 100);
    
    // Auto remove after 3 seconds
    setTimeout(() => {
        notification.style.opacity = '0';
        notification.style.transform = 'translateX(100%)';
        setTimeout(() => {
            notification.remove();
        }, 300);
    }, 3000);
}

// Add CSS for additional animations
const additionalCSS = `
    .animate-in {
        animation: slideInUp 0.6s ease-out;
    }
    
    .product-card.visible {
        opacity: 1;
        transform: translateY(0);
    }
    
    .product-card {
        opacity: 0;
        transform: translateY(20px);
        transition: all 0.3s ease;
    }
    
    @keyframes slideInUp {
        from {
            opacity: 0;
            transform: translateY(30px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
    
    .notification-toast {
        border-radius: 10px;
        box-shadow: 0 10px 25px rgba(0,0,0,0.1);
    }
    
    .product-image.loaded {
        filter: brightness(1.05) contrast(1.05);
    }
`;

// Inject additional CSS
const style = document.createElement('style');
style.textContent = additionalCSS;
document.head.appendChild(style); 