--[[
--
-- This file implements the LNVL.Opcode class.  See the document
--
--     docs/html/Instructions.html
--
-- for detailed information on opcodes and how we use them in LNVL.
--
--]]

-- Create the LNVL.Opcode class.
LNVL.Opcode = {}
LNVL.Opcode.__index = LNVL.Opcode

-- This contains all of the valid opcodes LNVL recognizes.
LNVL.Opcode.ValidOpcodes = {
    ["monologue"] = true,
    ["say"] = true,
    ["set-character-image"] = true,
    ["draw-character"] = true,
    ["change-scene"] = true,
    ["no-op"] = true,
}

-- The opcode constructor, which requires two arguments: the name of
-- an instruction as a string, and a table (which may be nil) of
-- arguments to give to that instruction later.
function LNVL.Opcode:new(name, arguments)
    local opcode = {}
    setmetatable(opcode, LNVL.Opcode)
    assert(LNVL.Opcode.ValidOpcodes[name] ~= nil,
           string.format("Unknown opcode %s", name))

    -- name: The name of the instruction this opcode will execute.
    opcode.name = name

    -- arguments: A table of additional arguments we will give to the
    -- instruction when executing it.
    opcode.arguments = arguments

    return opcode
end

-- This function converts Opcode objects to strings intended for
-- debugging purposes.
LNVL.Opcode.__tostring =
    function (opcode)
        output = string.format("Opcode %q = {\n", opcode.name)
        for key,value in pairs(opcode.arguments) do
            output = output .. string.format("\n\t%s: %s", key, value)
        end
        output = output .. "\n}"
        return output
    end

-- The following table contains all of the 'processor functions' for
-- opcodes.  Each key in the table the name of an opcode as a string;
-- these are the same keys which appear in the
-- LNVL.Opcode.ValidOpcodes table.  The value for each entry is
-- function which accepts one argument: an LNVL.Opcode object.  The
-- processor function will add any extra data or modify any existing
-- data for that particular instance of LNVL.Opcode and then return
-- either the modified object, or a new array of opcodes.
LNVL.Opcode.Processor = {}

-- Return the class as a module.
return LNVL.Opcode
