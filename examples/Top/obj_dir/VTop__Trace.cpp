// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "VTop__Syms.h"


void VTop___024root__traceChgSub0(VTop___024root* vlSelf, VerilatedVcd* tracep);

void VTop___024root__traceChgTop0(void* voidSelf, VerilatedVcd* tracep) {
    VTop___024root* const __restrict vlSelf = static_cast<VTop___024root*>(voidSelf);
    VTop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    if (VL_UNLIKELY(!vlSymsp->__Vm_activity)) return;
    // Body
    {
        VTop___024root__traceChgSub0((&vlSymsp->TOP), tracep);
    }
}

void VTop___024root__traceChgSub0(VTop___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    VTop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    vluint32_t* const oldp = tracep->oldp(vlSymsp->__Vm_baseCode + 1);
    if (false && oldp) {}  // Prevent unused
    // Body
    {
        tracep->chgBit(oldp+0,(vlSelf->clock));
        tracep->chgBit(oldp+1,(vlSelf->reset));
        tracep->chgIData(oldp+2,(vlSelf->io_test_in),32);
        tracep->chgIData(oldp+3,(vlSelf->io_test_out),32);
        tracep->chgIData(oldp+4,((IData)((0x3ffffffffULL 
                                          & ((QData)((IData)(vlSelf->io_test_in)) 
                                             << 1U)))),32);
        tracep->chgIData(oldp+5,((IData)((0x3ffffffffULL 
                                          & (3ULL * (QData)((IData)(
                                                                    (0x3ffffffffULL 
                                                                     & ((QData)((IData)(vlSelf->io_test_in)) 
                                                                        << 1U)))))))),32);
    }
}

void VTop___024root__traceCleanup(void* voidSelf, VerilatedVcd* /*unused*/) {
    VlUnpacked<CData/*0:0*/, 1> __Vm_traceActivity;
    VTop___024root* const __restrict vlSelf = static_cast<VTop___024root*>(voidSelf);
    VTop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    {
        vlSymsp->__Vm_activity = false;
        __Vm_traceActivity[0U] = 0U;
    }
}
