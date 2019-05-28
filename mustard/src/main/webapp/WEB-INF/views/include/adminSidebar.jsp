<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
      <div class="sidebar-sticky">
      <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted">
          <span><b>게시판 관리</b></span>
          <a class="d-flex align-items-center text-muted" href="#">
            <span data-feather="plus-circle"></span>
          </a>
        </h6>
        <ul class="nav flex-column">
          <li class="nav-item">
            <a class="nav-link active" href="/admin/adminMain">
              <span data-feather="home"></span>
              Main <span class="sr-only">(current)</span>
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="/admin/adminQna">
              <span data-feather="shopping-cart"></span>
              Q&A
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="/admin/adminMember">
              	회원관리
            </a>
          </li>
        <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted">
          <span>Boards</span>
          <a class="d-flex align-items-center text-muted" href="#">
            <span data-feather="plus-circle"></span>
          </a>
        </h6> 
        <ul class="nav flex-column mb-2">
          <li class="nav-item">
            <a class="nav-link" href="/admin/adminBoard?board_no=3">
              <span data-feather="file"></span>
              	정보게시판
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="/admin/adminBoard?board_no=4" >
              	홍보게시판
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="/admin/adminBoard?board_no=5" >
              	자유게시판
            </a>
          </li>
        </ul>
        
        <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted">
          <span>reports</span>
          <a class="d-flex align-items-center text-muted" href="#">
            <span data-feather="plus-circle"></span>
          </a>
        </h6>
        <ul class="nav flex-column mb-2">
          <li class="nav-item">
            <a class="nav-link" href="/admin/adminReports">
              <span data-feather="file"></span>
              	신고관리
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link disabled" href="/admin/adminControlMember" >
              	개별회원관리
            </a>
          </li>
        </ul>
      </div>