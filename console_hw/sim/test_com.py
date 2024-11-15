import cocotb
import os
import random
import sys
from math import log
import logging
from pathlib import Path
from cocotb.clock import Clock
from cocotb.triggers import Timer, ClockCycles, RisingEdge, FallingEdge, ReadOnly,with_timeout
from cocotb.utils import get_sim_time as gst
from cocotb.runner import get_runner

parameters = {}

async def escalate_input(dut, max):
    dut.rst_in.value = 1
    await ClockCycles(dut.clk_in, 3)
    dut.rst_in.value = 0
    for dum in range(3):
        await ClockCycles(dut.clk_in, 1)
        await FallingEdge(dut.clk_in)
        for i in range(max):
            dut.x_in.value = i
            dut.y_in.value = i
            dut.valid_in.value = 1
            await FallingEdge(dut.clk_in)
        dut.valid_in.value = 0
        dut.tabulate_in.value = 1
        await FallingEdge(dut.clk_in)
        dut.tabulate_in.value = 0
        await RisingEdge(dut.valid_out)

async def escalate_and_static_input(dut, max, static):
    dut.rst_in.value = 1
    await ClockCycles(dut.clk_in, 3)
    dut.rst_in.value = 0
    for dum in range(3):
        await ClockCycles(dut.clk_in, 1)
        await FallingEdge(dut.clk_in)
        for i in range(max):
            dut.x_in.value = i
            dut.y_in.value = static
            dut.valid_in.value = 1
            await FallingEdge(dut.clk_in)
        dut.valid_in.value = 0
        dut.tabulate_in.value = 1
        await FallingEdge(dut.clk_in)
        dut.tabulate_in.value = 0
        await RisingEdge(dut.valid_out)

def assert_averages(dut, expected):
    found = (int(dut.x_out.value), int(dut.y_out.value))
    if found != expected:
        dut._log.info(f'Expeceted: {expected}, but found: {found}')
        assert found == expected

@cocotb.test()
async def test_a(dut):
    """cocotb test for seven segment controller"""
    dut._log.info("Starting...")
    cocotb.start_soon(Clock(dut.clk_in, 10, units="ns").start())

    await escalate_input(dut, 700)
    assert_averages(dut, (349, 349))
    
    await escalate_and_static_input(dut, 700, 10)
    assert_averages(dut, (349, 10))

    await escalate_and_static_input(dut, 1, 200)
    assert_averages(dut, (0, 200))

    for i in range(20):
        await escalate_and_static_input(dut, 20, 15)
        assert_averages(dut, (9, 15))

    dut._log.info("Finished...")
    #await ReadOnly()


def com_runner():
    """Simulate the counter using the Python runner."""
    hdl_toplevel_lang = os.getenv("HDL_TOPLEVEL_LANG", "verilog")
    sim = os.getenv("SIM", "icarus")
    proj_path = Path(__file__).resolve().parent.parent
    sys.path.append(str(proj_path / "sim" / "model"))
    sources = [
        proj_path / "hdl" / "center_of_mass.sv", 
        proj_path / "hdl" / "divider.sv",     
    ]
    build_test_args = ["-Wall"]
    sys.path.append(str(proj_path / "sim"))
    runner = get_runner(sim)
    runner.build(
        sources=sources,
        hdl_toplevel="center_of_mass",
        always=True,
        build_args=build_test_args,
        parameters=parameters,
        timescale = ('1ns','1ps'),
        waves=True
    )
    run_test_args = []
    runner.test(
        hdl_toplevel="center_of_mass",
        test_module="test_com",
        test_args=run_test_args,
        waves=True
    )

if __name__ == "__main__":
    com_runner()