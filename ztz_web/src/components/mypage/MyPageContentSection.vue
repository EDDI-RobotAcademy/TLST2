<template>
  <section class="management-section">

    <div class="management-box first-box">
      <my-page-delivery-section/>
    </div>

    <div class="management-box">
      <OrderManagement/>
    </div>

    <div class="management-box no-border-bottom">
      <p class=" head-text">리뷰 관리</p>
    </div>

  </section>
</template>

<script>
import MyPageDeliverySection from "@/components/mypage/MyPageDeliverySection";
import OrderManagement from "@/components/mypage/OrderManagement";
export default {
  name: "MyPageContentSection",
  components: {OrderManagement, MyPageDeliverySection}
}
</script>
