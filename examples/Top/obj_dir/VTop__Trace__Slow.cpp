// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "VTop__Syms.h"


void VTop___024root__traceInitSub0(VTop___024root* vlSelf, VerilatedVcd* tracep) VL_ATTR_COLD;

void VTop___024root__traceInitTop(VTop___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    VTop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    {
        VTop___024root__traceInitSub0(vlSelf, tracep);
    }
}

void VTop___024root__traceInitSub0(VTop___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    VTop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    const int c = vlSymsp->__Vm_baseCode;
    if (false && tracep && c) {}  // Prevent unused
    // Body
    {
        tracep->declBit(c+1,"clock", false,-1);
        tracep->declBit(c+2,"reset", false,-1);
        tracep->declBus(c+3,"io_test_in", false,-1, 31,0);
        tracep->declBus(c+4,"io_test_out", false,-1, 31,0);
        tracep->declBit(c+1,"Top clock", false,-1);
        tracep->declBit(c+2,"Top reset", false,-1);
        tracep->declBus(c+3,"Top io_test_in", false,-1, 31,0);
        tracep->declBus(c+4,"Top io_test_out", false,-1, 31,0);
        tracep->declBus(c+3,"Top m_if_io_test_in", false,-1, 31,0);
        tracep->declBus(c+5,"Top m_if_io_test_out", false,-1, 31,0);
        tracep->declBus(c+5,"Top m_id_io_test_in", false,-1, 31,0);
        tracep->declBus(c+6,"Top m_id_io_test_out", false,-1, 31,0);
        tracep->declBus(c+3,"Top m_if io_test_in", false,-1, 31,0);
        tracep->declBus(c+5,"Top m_if io_test_out", false,-1, 31,0);
        tracep->declBus(c+5,"Top m_id io_test_in", false,-1, 31,0);
        tracep->declBus(c+6,"Top m_id io_test_out", false,-1, 31,0);
    }
}

void VTop___024root__traceFullTop0(void* voidSelf, VerilatedVcd* tracep) VL_ATTR_COLD;
void VTop___024root__traceChgTop0(void* voidSelf, VerilatedVcd* tracep);
void VTop___024root__traceCleanup(void* voidSelf, VerilatedVcd* /*unused*/);

void VTop___024root__traceRegister(VTop___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    VTop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    {
        tracep->addFullCb(&VTop___024root__traceFullTop0, vlSelf);
        tracep->addChgCb(&VTop___024root__traceChgTop0, vlSelf);
        tracep->addCleanupCb(&VTop___024root__traceCleanup, vlSelf);
    }
}

void VTop___024root__traceFullSub0(VTop___024root* vlSelf, VerilatedVcd* tracep) VL_ATTR_COLD;

void VTop___024root__traceFullTop0(void* voidSelf, VerilatedVcd* tracep) {
    VTop___024root* const __restrict vlSelf = static_cast<VTop___024root*>(voidSelf);
    VTop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    {
        VTop___024root__traceFullSub0((&vlSymsp->TOP), tracep);
    }
}

void VTop___024root__traceFullSub0(VTop___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    VTop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    vluint32_t* const oldp = tracep->oldp(vlSymsp->__Vm_baseCode);
    if (false && oldp) {}  // Prevent unused
    // Body
    {
        tracep->fullBit(oldp+1,(vlSelf->clock));
        tracep->fullBit(oldp+2,(vlSelf->reset));
        tracep->fullIData(oldp+3,(vlSelf->io_test_in),32);
        tracep->fullIData(oldp+4,(vlSelf->io_test_out),32);
        tracep->fullIData(oldp+5,((IData)((0x3ffffffffULL 
                                           & ((QData)((IData)(vlSelf->io_test_in)) 
                                              << 1U)))),32);
        tracep->fullIData(oldp+6,((IData)((0x3ffffffffULL 
                                           & (3ULL 
                                              * (QData)((IData)(
                                                                (0x3ffffffffULL 
                                                                 & ((QData)((IData)(vlSelf->io_test_in)) 
                                                                    << 1U)))))))),32);
    }
}
