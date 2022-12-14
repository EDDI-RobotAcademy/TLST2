<template>
  <section class="management-section">

    <div class="management-box first-box">
      <my-page-delivery-section/>
    </div>

    <div class="management-box">
      <p class=" head-text">주문관리</p>
    </div>

    <div class="management-box no-border-bottom">
      <p class=" head-text">리뷰 관리</p>
    </div>

  </section>
</template>

<script>
import MyPageDeliverySection from "@/components/mypage/MyPageDeliverySection";
export default {
  name: "MyPageContentSection",
  components: {MyPageDeliverySection}
}
</script>
